require 'net/https'
require 'pathname'
require 'tmpdir'
require 'uri'

class Pathname
  def self.make_temporary_dir
    Pathname.new(Dir.mktmpdir)
  end
end

class Net::HTTP
  def self.start_session(options = {}, &block)
    session = Net::HTTP.new(*options.values_at(:address, :port, :proxy_addr, :proxy_port, :proxy_user, :proxy_pass))
    session.use_ssl = options[:use_ssl]
    session.start(&block)
  end
end

module URI
  class HTTP
    def http?;  true  end
    def https?; false end
  end

  class HTTPS
    def http?;  false end
    def https?; true  end
  end
end

module DownloadHelper
  module_function

  def fetch(uri, dest, options = {})
    Net::HTTP.start_session(:host => uri.host, :port => uri.port, :use_ssl => uri.https?) do |session|
      session.request_get(uri.request_uri) do |response|
        case response
        when Net::HTTPSuccess
          open(dest, 'w') do |f|
            response.read_body do |data|
              f << data
            end
          end
        when Net::HTTPRedirection
          fetch(URI(response['location'], dest, options))
        else
          response.value
        end
      end
    end
  end
end

def distribution_task(name, files)
  namespace name do
    task :env do
      @home = Pathname.new('~').expand_path
      @pwd = Pathname.pwd.expand_path
      @files = FileList.new.include(files)
      @exists_files, @missing_files = @files.partition {|f| (@home + f).exist? }
    end

    desc "Export #{name.to_s.capitalize} files to $HOME"
    task :export => :env do
      @missing_files.each do |f|
        ln_s @pwd + f, @home + f
      end
    end

    desc "Unlink #{name.to_s.capitalize} files from #HOME"
    task :unlink => :env do
      @exists_files.map { |f| @home + f }.select(&:symlink?).each do |path|
        remove path
      end
    end
  end
end

namespace :dotfiles do
  distribution_task :vim,        %w(.vimrc .gvimrc .vim)
  distribution_task :zsh,        %w(.zshrc .zshenv .zsh.d)
  distribution_task :screen,     %w(.screenrc .screen)
  distribution_task :vimperator, %w(.vimperatorrc .vimperatorrc.css .vimperator)
  distribution_task :tmux,       %w(.tmux.conf)
  distribution_task :git,        %w(.gitconfig)
  distribution_task :rubygems,   %w(.gemrc)
  distribution_task :rvm,        %w(.rvmrc)
  distribution_task :pry,        %w(.pryrc)
  distribution_task :irb,        %w(.irbrc)
  distribution_task :perl,       %w(.proverc .re.pl)
  distribution_task :irssi,      %w(.irssi)

  namespace :perlbrew do
    desc 'Install perlbrew'
    task :install do
      include DownloadHelper

      tmpdir = Pathname.make_temporary_dir
    end
  end
end
