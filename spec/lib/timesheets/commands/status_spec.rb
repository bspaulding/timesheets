class MockLogger
	def log(string = "")
		@log ||= ""
		@log << string
	end
end

describe Timesheets::Commands::Status do
	describe "active_time == 0 minutes" do
		it "prints 0 minutes" do
			status = Timesheets::Commands::Status.new
			mock_logger = MockLogger.new

			status.stub :logger, mock_logger do
				status.stub :hours_in_entry, 0 do
					status.stub :rows, [[DateTime.new.to_s,nil]] do
						status.run
						assert_equal mock_logger.log, "Current work session has been active for 0 minutes. Total time today is 0 minutes."
					end
				end
			end

		end
	end
end
