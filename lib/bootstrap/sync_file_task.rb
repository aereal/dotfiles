require "rake/tasklib"

class SyncFileTask < Rake::TaskLib
  include Rake::DSL if defined?(Rake::DSL)

  attr_accessor :name, :source_file, :destination_file, :install_method
  protected :name=, :source_file=, :destination_file=, :install_method=

  def initialize(task_name, &block)
    self.name = task_name.intern
    self.instance_eval(&block) if block_given?

    namespace self.name do
      file self.destination_file => self.source_file do |t|
        mkdir_p File.dirname(t.name)
        self.install(self.source_file, self.destination_file)
      end

      task :install => self.destination_file
      task :backup => self.destination_file do |t|
      end
    end

    desc "Install #{self.name}"
    task self.name => :"#{self.name}:install"
  end

  def install(src, dst)
    self.send(self.install_method == :symlink ? :ln_sf : :cp, src, dst)
  end
end
