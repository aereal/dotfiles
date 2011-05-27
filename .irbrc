require "rubygems"
require "wirb"

Wirb.start

module Kernel
	alias_method :say, :puts
end

class Object
	def local_methods
		(methods - Object.instance_methods).sort
	end
end

