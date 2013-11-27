#idm_log_parse.rb
require_relative "IDMTransaction"

class Logfile

INCLUDE_SUCCESS="level=\"success\""
INCLUDE_ERROR="level=\"error\""
INCLUDE_PERFORM_QUERY="Performing operation query"
INCLUDE_SYNTHETIC_ADD="Synthetic add"
INCLUDE_NO_MATCH="No matches found."
INCLUDE_ADD_TYPE="type(add-entry)"
INCLUDE_MODIFY_TYPE="type(modify-entry)"

	def initialize(p)
		@path = p
		@count_query=0
		@count_success=0
		@count_error=0
		@count_synthetic_add=0
		@count_no_match=0
		@count_add_entry=0
		@count_modify_entry=0
	end

	def counts
		return 3
	end

	def stats
		inTransaction=false
		File.open( @path, 'r') do |f|
	 		f.each_line do |line|
	 			if line.include? INCLUDE_SUCCESS
	 				@count_success+=1
	 			end
	 			
	 			if line.include? INCLUDE_ERROR
	 				@count_error+=1
	 				#puts line
	 			end
	 			
	 			if line.include? INCLUDE_PERFORM_QUERY
	 				@count_query+=1
	 			end

	 			if line.include? INCLUDE_SYNTHETIC_ADD
	 				@count_synthetic_add+=1
	 			end

	 			if line.include? INCLUDE_NO_MATCH
	 				@count_no_match+=1
	 			end

	 			if line.include? INCLUDE_ADD_TYPE
	 				@count_add_entry+=1
	 			end

	 			if line.include? INCLUDE_MODIFY_TYPE
	 				@count_modify_entry+=1
	 			end

	 			if line.include? 'Start transaction'
	 				inTransaction=true
	 				@trans=IDMTransaction.new (line)
	 			end

	 			if line.include? 'End transaction'
	 				inTransaction=false
	 			end

	 			if inTransaction
	 				@trans.lineFeed(line)
	 			end

	  		end
 		end
 		puts "Status Events | Success: #{@count_success}"
 		puts "Status Events | Error: #{@count_error}"
 		puts "Query Events : #@count_query"
 		puts "Synthetic Adds : #{@count_synthetic_add}"
 		puts "Add Entry Events : #{@count_add_entry}"
 		puts "Modify Entry Events : #{@count_modify_entry}"
 		puts "Query with no Match Found : #{@count_no_match}"
 		return @count_success, @count_error, @count_synthetic_add, @count_no_match
	end
end