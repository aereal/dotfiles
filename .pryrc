# vim:set ft=ruby:

def pbcopy(str)
  IO.popen('pbcopy', 'r+') {|io| io.puts str }
end

Pry.config.commands.command 'hcopy', 'Copy a history to clipboard' do |n|
  pbcopy _pry_.input_array[n ? n.to_i : -1]
end

Pry.config.commands.command 'copy', 'Copy a text to clipboard' do |str|
  pbcopy str
end

Pry.config.commands.command 'lastcopy', 'Copy the last result to clipboard' do
  pbcopy _pry_.last_result.chomp
end

if defined?(Hirb)
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @original_print = Pry.config.print
      Pry.config.print = -> (output, value) {
        Hirb::View.view_or_page_output(value) || @original_print.call(output, value)
      }
    end

    def disable_output_method
      Pry.config.print = @original_print
      @output_method = nil
    end
  end

  Hirb.enable
end
