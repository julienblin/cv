require 'Sources/base_transformer'

class PdfTransformer < BaseTransformer
  
  def initialize(cv, output_dir, html_output_dir)
		@cv = cv
		@output_dir = output_dir
		@html_output_dir = html_output_dir
	end

	def transform
		wipe_output_dir
		
		langs = [:en, :fr]
    langs.each do |lang|
      @resources = YamlParser.new('Data/resources.yml').read.resources.send(lang)
      html_file = @html_output_dir + "/index.#{lang}.html"
      pdf_file_name = @output_dir + "/#{@resources.cv}-#{@cv.name}.#{lang}.pdf"
		  
		  `Bin/wkhtmltopdf --print-media-type --page-size Letter --title "#{@resources.cv} #{@cv.name}" "#{html_file}" "#{pdf_file_name}"`
    end
	end
  
end