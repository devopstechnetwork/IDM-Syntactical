#idm_log_parse_tests.rb

require_relative "idmlog"
require_relative "IDMTransaction"
require "test/unit"

class LogfileTests < Test::Unit::TestCase

	def test_simple_ParseForsuccess
		logFile = Logfile.new('examples/CRM_NTLM.log')
		assert_equal([261, 41, 3, 9], logFile.stats)
		assert_equal(3, logFile.counts)
	end

	def test_transaction_2mil
		@transaction=IDMTransaction.new('[11/12/13 16:21:10.071]:crmn ST:Start transaction.')
		@transaction.end('[11/12/13 16:21:10.073]:crmn ST:End transaction.')
		assert_equal(0.002, @transaction.TimeTaken)
	end

	def test_transaction_2sec
		@transaction=IDMTransaction.new('[11/12/13 16:21:10.071]:crmn ST:Start transaction.')
		@transaction.end('[11/12/13 16:21:12.071]:crmn ST:End transaction.')
		assert_equal(2.000, @transaction.TimeTaken)
	end

	def test_transaction_2min
		@transaction=IDMTransaction.new('[11/12/13 16:21:10.071]:crmn ST:Start transaction.')
		@transaction.end('[11/12/13 16:23:10.071]:crmn ST:End transaction.')
		assert_equal(120.000, @transaction.TimeTaken)
	end		
end