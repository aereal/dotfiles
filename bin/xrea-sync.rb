#!/usr/bin/env ruby

require 'optparse'
require 'pathname'

pwd = Pathname.pwd.expand_path.cleanpath.to_s.split('/')
@user, @host = *pwd.grep(/^(.+)\.(s\d+\.xrea\.com)/) { [$1, $2] }[0]

raise "can't find @user and @host" if @user.nil? || @host.nil?

@dry  = false
@src  = '/home/aereal/devel/%s.%s/public_html'
@dst  = '/virtual/%s/public_html'

OptionParser.new do |opts|
	opts.on('-n', '--dry-run') { @dry = true }
	opts.parse!
end

def sync(dry=false)
	dir = Pathname.new(@src % [@user, @host])
	raise "#{@user}.#{@host} is not exists." unless dir.exist?

	system "rsync #{dry ? '--dry-run' : ''} -vptr #{dir}/ #{@user}@#{@host}:#{@dst % @user}"
end

if $0 == __FILE__
	unless sync(@dry)
		puts 'rsync failed. retry after 5min.'

		(5 * 60).downto(0) do |i|
			puts i
			$stdout.flush
			sleep 1
		end
		sync(@dry)
	end
end

