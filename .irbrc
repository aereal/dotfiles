require "rubygems"
require "wirble"

Wirble.init(:skip_prompt => :DEFAULT)
Wirble.colorize

module Kernel
	alias_method :say, :puts
end

class Object
	def local_methods
		(methods - Object.instance_methods).sort
	end
end

