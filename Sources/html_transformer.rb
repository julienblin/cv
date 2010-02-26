
require 'haml'
require 'Sources/base_transformer'

class HtmlTransformer < BaseTransformer

	def initialize(data, output_dir)
		@data = data
		@output_dir = output_dir
	end

	def transform
		wipe_output_dir
		
		template = File.read('Sources/html_templates/index.haml')
		haml_engine = Haml::Engine.new(template)
		
		[:en, :fr].each do |lang|
		  resources = YamlParser.new('Data/resources.yml').read.resources.send(lang)
		  output = haml_engine.render(Object.new, :cv => @data, :lang => lang, :resources => resources)
  		File.open(@output_dir + "/index.#{lang}.html", 'w') do |f|
  			f.write(output)
  		end

  		FileUtils.copy('Sources/html_templates/cvstyle.css', @output_dir)
		end
	end
	
end