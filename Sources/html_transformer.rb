
require 'haml'
require 'Sources/base_transformer'
require 'Sources/string_additions'

class HtmlTransformer < BaseTransformer

	def initialize(data, output_dir, credentials)
		@data = data
		@output_dir = output_dir
		@credentials = credentials
	end

	def transform
		wipe_output_dir
		
		template = File.read('Sources/html_templates/index.haml')
		haml_engine = Haml::Engine.new(template)
		langs = [:en, :fr]
		langs.each do |lang|
		  resources = YamlParser.new('Data/resources.yml').read.resources.send(lang)
		  output = haml_engine.render(Object.new, :cv => @data, :credentials => @credentials, :lang => lang, :other_langs => langs.select {|l| l != lang}, :resources => resources)
  		File.open(@output_dir + "/index.#{lang}.html", 'w') do |f|
  			f.write(output)
  		end

  		FileUtils.copy('Sources/html_templates/cvstyle.css', @output_dir)
  		FileUtils.copy('Sources/html_templates/.htaccess', @output_dir)
  		FileUtils.copy('Sources/html_templates/robots.txt', @output_dir)
  		FileUtils.copy('Sources/html_templates/odt.png', @output_dir)
		end
	end
	
end