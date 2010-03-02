
require 'serenity'

# authorize tags in input...
module Serenity
  class StringLine < CodeLine
    def to_buf
        " _buf << (" << escape_code(@text) << ").to_s.escape_xml.split(/\n/).join(\"<text:line-break/>\");"
    end
  end
end

require 'Sources/base_transformer'
require 'Sources/string_additions'

class OdtTransformer < BaseTransformer
  include Serenity::Generator

	def initialize(cv, output_dir, credentials)
		@cv = cv
		@output_dir = output_dir
		@credentials = credentials
	end

	def transform
		wipe_output_dir
		
		langs = [:en, :fr]
		langs.each do |lang|
		  @lang = lang
		  @resources = YamlParser.new('Data/resources.yml').read.resources.send(lang)
		  render_odt 'Sources/odt_templates/template.odt'
		  FileUtils.mv('Sources/odt_templates/template_output.odt', @output_dir + "/#{@resources.cv}-#{@cv.name}-#{lang}.odt")
		end
	end
	
end