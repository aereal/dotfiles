require 'rake'
require 'rake/tasklib'

module RubyInstall
	class Task < ::Rake::TaskLib
	include ::Rake::DSL if defined?(::Rake::DSL)

		attr_reader :version
		attr_reader :ruby_versions_root
		attr_reader :opt_dirs
		attr_reader :url
		attr_reader :extension
		attr_reader :src_root
		attr_reader :src_dir
		attr_reader :archive_file

		def initialize(_version, args = {}, &block)
			@version = _version
			setup(args || {})
			create_task
		end

		def setup(args = {})
			@ruby_versions_root = args[:ruby_versions_root] || File.expand_path('~/.rbenv/versions')
			@opt_dirs           = args[:opt_dirs] || []
			@extension          = args[:extension] || 'tar.bz2'
			@src_root           = File.expand_path(args[:src_root] || 'src')

			@src_dir      = File.join(src_root, "ruby-#{version}")
			@archive_file = File.join(src_root, "ruby-#{version}.#{extension}")
			@url          = "http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{version}.#{extension}"
		end

		def create_download_task
			directory src_root

			file archive_file => [src_root] do
				sh 'curl', '-sSLfo', archive_file, "#{url}"
			end

			file src_dir => [archive_file] do
				cd src_root do
					sh 'tar', 'jxf', archive_file
				end
			end
		end

		def create_install_task
			file ruby_version_dir => [src_dir, opt_dirs] do
				cd src_dir do
					sh './configure', *configure_options
					sh 'make'
					sh 'make install'
				end
			end

			desc "Install Ruby #{version}"
			task :install => [ruby_version_dir]
		end

		def create_task
			namespace version.gsub(/[^0-9a-zA-Z]/, '') do
				create_download_task
				create_install_task
			end
		end

		def ruby_version_dir
			File.join(ruby_versions_root, version)
		end

		def configure_options
			options = %W[
				--prefix=#{ruby_version_dir}
				--enable-shared
				--with-out-ext=tk,tk/*
			]

			unless opt_dirs.empty?
				options << "--with-opt-dir=#{opt_dirs.join(':')}"
			end

			options
		end
	end
end
