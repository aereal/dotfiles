#!/usr/bin/env ruby
=begin TracWiki

= CocProxy =

めんどくさいことしない置換プロキシー

== 使い方 ==

 1. http://svn.coderepos.org/share/lang/ruby/cocproxy/proxy.rb
    をダウンロード
 2. `files' というディレクトリをつくる
 3. 置換したいファイルをてきとうにつっこむ
 4. ruby proxy.rb
 5. ポートとか表示されるのでブラウザの設定を変える

デフォルトだと、

 1. #{File.basename(req.path_info)}",
 2. #{req.host}#{req.path_info}",
 3. #{req.host}/#{File.basename(req.path_info)}",
 4. .#{req.path_info}",

がスキャンされ、ヒットしたら置換される。

例えば、http://example.com/test/foo/bar.css にアクセスすると

 1. files/bar.css
 2. files/example.com/test/foo/bar.css
 3. files/example.com/bar.css
 4. files/test/foo/bar.css

が順にスキャンされ、最初に発見されたファイルが置換されブラウザに返される。

== 部分置換 ==

正規表現により部分的に置換することもできる。

http://example.com/hoge.html というファイルの style 要素を置換したければ、
ルールにヒットするファイルに

{{{
proxy-replace: <style type="text/css">\s*<!--([^<]+)-->\s*</style>
}}}

などと書き、さらに置換したい内容を書けば良い。
指定した正規表現のキャプチャのうち、第一番目のキャプチャが該当ファイルの内容で
置換される。

単純にファイル内容を追記したい場合は

{{{
proxy-replace: (\z)
}}}

と書けば良い。(\z は文字列末尾にマッチする)


また、置換後のファイルでは proxy-replace 以降、行末までは削除されるため、
proxy-replace のあとを HTML エスケープなどする必要はない。

== キャッシュ ==

開発用のプロキシでリロードをしまくる性質上、
置換対象のファイルでない限り全てのリソースを無条件にキャッシュする。

もしキャッシュをクリアしたければ、?clearcache=1 をつけて、
適当な URL にアクセスすれば良い。

== さらに ==

proxy.rb はカレントディレクトリの proxy-config.yaml を設定として読みこむ、
このファイルはなくてもよいが、使用することで設定を上書きできる。

また、double_screen.rb というファイルが require できればそれをロードする。
double_screen.rb は標準出力と標準エラー出力を左右にわけて表示するもので、
使用することで、プロキシの動作が読み易くなる。

== Download / Repos. ==

1ファイル完結版

 * http://svn.coderepos.org/share/lang/ruby/cocproxy/proxy.rb

全部

 * http://svn.coderepos.org/share/lang/ruby/cocproxy/


== Principles ==

 * 基本的に1つのファイルで完結すること
 * ruby1.9 メイン
 * 標準ライブラリで動くこと


== Ref. ==

 * http://la.ma.la/blog/diary_200607172004.htm


== License ==

Public Domain

=end

require 'webrick'
require 'webrick/httpproxy'
require 'uri'
require 'yaml'
require "pp"
require "pathname"
require "stringio"
require "zlib"
require "optparse"

class CocProxyCommand
	VERSION = "$Revision$"
	DEFAULT_CONFIG = {
		:Port        => 5432,
		:ProxyVia    => false,
		:Logger      => WEBrick::Log.new(nil, 0),
		:AccessLog   => WEBrick::Log.new(nil, 0),
		:FilterDir   => "files",
		:Rules       => [
			"\#{File.basename(req.path_info)}",
			"\#{req.host}\#{req.path_info}",
			"\#{req.host}/\#{File.basename(req.path_info)}",
			".\#{req.path_info}",
		]
	}

	def self.run(argv)
		new(argv.dup).run
	end

	def initialize(argv)
		@argv = argv
		@parser = OptionParser.new do |parser|
			parser.banner = <<-EOB.gsub(/^\t+/, "")
				Usage: #$0 [options]
			EOB

			parser.separator ""
			parser.separator "Options:"

			parser.on("-c", "--config CONFIG.yaml") do |config|
				begin
					@config = YAML.load_file(config)
				rescue Errno::ENOENT
					puts "#{config} is not found"
					exit
				end
			end

			parser.on("-p", "--port PORT", "Specify port number. This option overrides any config.") do |port|
				@port = port.to_i
			end

			parser.on("-n", "--no-cache", "Disable cache.") do |port|
				@nocache = true
			end

			parser.on("--disable-double-screen", "Disable loading double_screen.rb") do |c|
				@disable_double_screen = c
			end

			parser.on("--version", "Show version string `#{VERSION}'") do
				puts VERSION
				exit
			end
		end
	end

	def run
		@parser.order!(@argv)
		$stdout.sync = true

		unless @config
			begin
				@config = YAML.load_file("proxy-config.yaml")
				puts "proxy-config.yaml was found. Use it."
			rescue Errno::ENOENT
				@config = {
					"server" => {
					},
				}
				puts "Use default configuration."
			end
		end

		server_config = DEFAULT_CONFIG.update(@config["server"])
		server_config[:Port]    = @port if @port
		server_config[:nocache] = @nocache
		server_config[:ProxyURI] = URI.parse(server_config[:ProxyURI]) if server_config[:ProxyURI]

		unless @disable_double_screen
			begin
				require "double_screen.rb"
			rescue LoadError => e
			end
		end
		puts "Port : #{server_config[:Port]}"
		puts "Dir  : #{server_config[:FilterDir]}/"
		puts "Cache: #{!server_config[:nocache]}"
		puts "Rules:"
		server_config[:Rules].each_with_index do |item, index|
			puts "    #{index+1}. #{item}"
		end

		srv = ArrogationProxyServer.new(server_config)
		trap(:INT) { srv.shutdown }
		srv.start
	end

	class ArrogationProxyServer < WEBrick::HTTPProxyServer
		def proxy_service(req, res)

			referer = req.header["referer"]
			dir = @config[:FilterDir]
			$stderr.puts req.path_info if $DEBUG
			$stderr.puts req.query.inspect if $DEBUG

			content    = ""
			local_path = ""

			@config[:Rules].each do |path|
				path = "#{dir}/#{eval("%Q(#{path})")}"
				$stderr.puts "Checking #{path.to_s}"
				if FileTest.file? path
					puts "Hit Arrogation: #{req.path_info}"
					local_path = path
					content = File.open(path).binmode.read
					break
				end
			end

			req.header.delete("HTTP_IF_MODIFIED_SINCE")

			case
			when content =~ /proxy-replace:\s*(.+)\s*/
				content.sub!(/proxy-replace:\s*(.+)\s*/, "")
				regexp = Regexp.new(Regexp.last_match[1])
				puts "Replace Regexp: #{regexp.source}"
				puts " <= #{local_path}"
				super
				case (res["Content-Encoding"] || "").downcase
				#when "deflate"
				#when "compress"
				when "gzip"
					res["Content-Encoding"] = nil
					res.body = Zlib::GzipReader.wrap(StringIO.new(res.body)) {|gz| gz.read }
				end

				p res

				m = res.body.match(regexp)
				if m && m[1]
					res.body[m.begin(1)..(m.end(1)-1)] = content
				else
					puts "In-place Regexp match failed..."
				end
				res["Content-Length"] = res.body.length
			when content !~ /\A\s*\Z/
				mime_types = WEBrick::HTTPUtils::DefaultMimeTypes.update(@config[:MimeTypes])
				res.header["Content-Type"] = WEBrick::HTTPUtils.mime_type(req.path_info, mime_types)
				res.body = content
				puts "Rewrote: <= #{local_path}"
			else
				@cache = {} if !@cache || req.query.key?("clearcache")
				r = @cache[req.request_uri.to_s]

				if r
					r.instance_variables.each do |i|
						res.instance_variable_set(i, r.instance_variable_get(i))
					end
					$stderr.puts "From Cache: #{req.request_uri}"
				else
					super
					unless @config[:nocache]
						@cache[req.request_uri.to_s] = res.dup
						$stderr.puts "Cached: #{req.request_uri}"
					end
				end
			end
			req.header["referer"] = ["http://#{req.header["host"][0]}"]
		rescue Exception => e
			puts $@
			puts $!
		end
	end
end

CocProxyCommand.run(ARGV)
