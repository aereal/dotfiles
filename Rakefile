require 'pathname'

HOME = Pathname.new('~').expand_path
PWD = Pathname.pwd.expand_path

namespace :dotfiles do
  namespace :vim do
    task :env do
      @files = FileList.new.include(%w(.vimrc .gvimrc .vim))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export Vim files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :zsh do
    task :env do
      @files = FileList.new.include(%w(.zshrc .zshenv .zsh.d))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export Zsh files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :screen do
    task :env do
      @files = FileList.new.include(%w(.screenrc .screen))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export Screen files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :vimperator do
    task :env do
      @files = FileList.new.include(%w(.vimperatorrc .vimperatorrc.css .vimperator))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export Vimperator files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :tmux do
    task :env do
      @files = FileList.new.include(%w(.tmux.conf))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export Tmux files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :git do
    task :env do
      @files = FileList.new.include(%w(.gitconfig))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export Git files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :rubygems do
    task :env do
      @files = FileList.new.include(%w(.gemrc))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export RubyGems files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :rvm do
    task :env do
      @files = FileList.new.include(%w(.rvmrc))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export RVM files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :pry do
    task :env do
      @files = FileList.new.include(%w(.pryrc))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export Pry files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :irb do
    task :env do
      @files = FileList.new.include(%w(.irbrc))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export IRB files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end

  namespace :perl do
    task :env do
      @files = FileList.new.include(%w(.proverc .re.pl))
      @exists_files = @files.select {|f| (PWD + f).exist? }
    end

    desc 'Export IRB files to $HOME'
    task :export => :env do
      (@files - @exists_files).each do |f|
        ln_s PWD + f, HOME + f
      end
    end
  end
end
