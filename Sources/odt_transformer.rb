
require 'serenity'

require 'Sources/base_transformer'
require 'Sources/string_additions'

class OdtTransformer < BaseTransformer

	def initialize(data, output_dir, credentials)
		@data = data
		@output_dir = output_dir
		@credentials = credentials
	end

	def transform
		wipe_output_dir
		
	end
	
end