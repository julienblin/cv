require 'yaml'
require 'ostruct'

class Object
    def to_openstruct
       self
    end
 end

class Array
    def to_openstruct
       map{ |el| el.to_openstruct }
    end
end

class Hash
    def to_openstruct
       mapped = {}
       each{ |key,value| mapped[key] = value.to_openstruct }
       OpenStruct.new(mapped)
    end
end

module YAML
    def self.load_openstruct(source)
       self.load(source).to_openstruct
    end
end

class YamlParser

	def initialize(filename)
		@yaml_file = filename
	end
	
	def	read
		YAML.load_openstruct(File.read(@yaml_file))
	end

end