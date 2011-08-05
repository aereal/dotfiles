require "rubygems"

begin
	require "wirb"

	Wirb.load_colorizer :Paint
	Wirb.start
rescue LoadError
end

module Kernel
	alias_method :say, :puts
end

class Object
	def local_methods
		(methods - Object.instance_methods).sort
	end
end

