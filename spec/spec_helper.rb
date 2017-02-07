require 'active_record'
require 'database_cleaner'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/reporters'
require 'minitest/spec'
require 'sequel'

# Improved Minitest output (color and progress bar)
Minitest::Reporters.use!(
	[Minitest::Reporters::SpecReporter.new],
	ENV,
	Minitest.backtrace_filter
)

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

DatabaseCleaner.strategy = :truncation

class Minitest::Spec
	before :each do
		DatabaseCleaner.start
	end

	after :each do
		DatabaseCleaner.clean
	end
end
