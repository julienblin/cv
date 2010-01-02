
require 'fileutils'

class BaseTransformer
	
	def wipe_output_dir
		FileUtils.rm_rf @output_dir
		begin
			FileUtils.mkdir @output_dir
		rescue
			sleep 1 #lovely FileUtils on Windows...
			FileUtils.mkdir @output_dir
		end
	end
	
end