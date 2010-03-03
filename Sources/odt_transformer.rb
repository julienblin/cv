require 'Sources/string_additions'
gem 'serenity-odt', '=0.1.1'
require 'serenity'

# monkey patching to handle links and new lines.
module Serenity
  class StringLine < CodeLine
    def to_buf
      " _buf << (" << escape_code(@text) << ").to_s.odt_prevent_links.escape_xml.odt_convert_links_back.split(/\n/).join(\"<text:line-break/>\");"
    end
  end
end

require 'Sources/base_transformer'

class NilClass
  def to_end_date(res)
    res.today
  end
end

class Date
  def to_end_date(res)
    self.strftime(res.date_formatting)
  end
end

class Array
  def in_groups_of(number, fill_with = nil, &block) 
    require 'enumerator' 
    collection = dup 
    collection << fill_with until collection.size.modulo(number).zero? 
    collection.each_slice(number, &block) 
  end
end

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
		  FileUtils.mv('Sources/odt_templates/template_output.odt', @output_dir + "/#{@resources.cv}-#{@cv.name}.#{lang}.odt")
		end
	end
	
end