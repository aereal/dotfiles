require 'pathname'
require 'minitest/autorun'
require 'minitest/spec'
require 'yaml'

HOME         = Pathname.new(ENV.fetch('HOME'))
PROJECT_DIR  = Pathname.new(__FILE__).expand_path.parent.parent
SOURCE_DIR   = PROJECT_DIR
DEST_DIR     = Pathname.new(ENV.fetch('DOTFILES_INSTALL_DIR', HOME))
CONFIG       = YAML.load_file(PROJECT_DIR + '.dotfiles.yml')
DOTFILES     = CONFIG['dotfiles']
DOTFILES_MAP = DOTFILES.map {|f|
  { basename: f, source: SOURCE_DIR + f, dest: DEST_DIR + f }
}

DOTFILES_MAP.each do |dotfile|
  describe dotfile[:basename] do
    it "is symlink to source" do
      source = dotfile[:source]
      dest   = dotfile[:dest]

      dest.symlink?.must_equal(true)
      dest.readlink.must_equal(source)
    end
  end
end
