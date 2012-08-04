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
