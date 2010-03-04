require 'Sources/base_transformer'

class PdfTransformer < BaseTransformer
  
  def initialize(output_dir, odt_output_dir)
		@output_dir = output_dir
		@odt_output_dir = odt_output_dir
	end

	def transform
		wipe_output_dir
		start_soffice_server
		Dir.glob("#{@odt_output_dir}/*.odt").each do |file|
		  odt_file_name = File.basename(file)
		  pdf_file_name = "#{odt_file_name[0, odt_file_name.size - 4]}.pdf"
		  puts "Converting #{odt_file_name} to #{pdf_file_name}..."
		  `java -jar Bin/jodconverter-2.2.2/lib/jodconverter-cli-2.2.2.jar "#{file}" "#{@output_dir}/#{pdf_file_name}"`
	  end
		stop_soffice_server
	end
	
	def start_soffice_server
	  puts "Starting OpenOffice server..."
	  Thread.new do
      @sofficepipe = IO.popen("/Applications/OpenOffice.org.app/Contents/MacOS/soffice.bin -headless -accept=\"socket,host=127.0.0.1,port=8100;urp;\" -nofirststartwizard")
    end
    sleep 5
	end
	
	def stop_soffice_server
	  puts "Terminating OpenOffice server (pid #{@sofficepipe.pid})..."
	  Process.kill("QUIT", @sofficepipe.pid.to_i)
	end
  
end