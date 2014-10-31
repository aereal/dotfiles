require 'pathname'

# methods
def env_or_default(env: , default: )
  ENV.fetch(env, default)
end

def ensure_pathname(maybe_pathname)
  maybe_pathname === Pathname ? maybe_pathname : Pathname.new(maybe_pathname)
end

class InstallRecipe
  attr_reader :name, :source, :destination

  def initialize(name: , source: , destination: )
    @name        = name
    @source      = ensure_pathname(source)
    @destination = ensure_pathname(destination)
  end

  def install
    if self.destination.exist?
      puts "Skip #{self.name}"
      return
    end
    FileUtils.ln_s self.source.to_s, self.destination.to_s, verbose: true
  end
end

# constants
INSTALL_DIRECTORY    = ensure_pathname(env_or_default(env: 'INSTALL_DIRECTORY', default: '~')).expand_path
SOURCE_DIRECTORY     = ensure_pathname(env_or_default(env: 'SOURCE_DIRECTORY', default: Dir.pwd)).expand_path
DOTFILES_IGNORE_FILE = ensure_pathname(env_or_default(env: 'DOTFILES_IGNORE_FILE', default: SOURCE_DIRECTORY + '.dotfiles.ignore')).expand_path

IGNORED_DOTFILES     = DOTFILES_IGNORE_FILE.each_line.map {|f| SOURCE_DIRECTORY.join(f.strip) }
DOTFILES             = SOURCE_DIRECTORY.each_child.select {|e| e.basename.to_s.start_with?(?.) }
INSTALLABLE_DOTFILES = DOTFILES - IGNORED_DOTFILES
INSTALL_NAMES        = INSTALLABLE_DOTFILES.map {|f| f.relative_path_from(SOURCE_DIRECTORY) }
INSTALL_RECIPES      = INSTALL_NAMES.map {|name|
  InstallRecipe.new(name: name, source: SOURCE_DIRECTORY.join(name), destination: INSTALL_DIRECTORY.join(name))
}

desc "Install dotfiles into #{INSTALL_DIRECTORY}"
task :install do
  INSTALL_RECIPES.each do |recipe|
    recipe.install
  end
end
