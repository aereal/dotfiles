module Dotfiles
  class Error < ::StandardError; end

  def assert_linked_dotfile(src, dest)
    raise Dotfiles::Error, "#{dest} does not exist" unless File.exist?(dest)
    raise Dotfiles::Error, "#{dest} is not symlink" unless File.symlink?(dest)
    raise Dotfiles::Error, "#{dest} not linked correctly" unless src == File.readlink(dest)
  rescue Dotfiles::Error => e
    warn "\e[31mNG\e[0m: #{e}"
    return false
  else
    puts "\e[32mOK\e[0m: #{dest}"
    return true
  end
  module_function :assert_linked_dotfile
end
