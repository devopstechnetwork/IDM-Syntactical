require 'date'
require 'date/format'
require 'time'
class IDMTransaction

	def initialize(startTransaction)
		@start = Time.parse(startTransaction)
	end

	def end(endTransaction)
		@end = Time.parse (endTransaction)
	end

	def lineFeed(line)
		#code
	end

	def TimeTaken
		return @end-@start
	end

end