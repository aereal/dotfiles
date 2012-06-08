require 'pathname'

def distribution_task(name, files)
  namespace name do
    task :env do
      @home = Pathname.new('~').expand_path
      @pwd = Pathname.pwd.expand_path
      @files = FileList.new.include(files)
      @exists_files, @missing_files = @files.select {|f| (@pwd + f).exist? }
    end

    desc "Export #{name.to_s.capitalize} files to $HOME"
    task :export => :env do
      @missing_files.each do |f|
        ln_s @pwd + f, @home + f
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
end
