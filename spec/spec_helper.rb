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

# Database connections
DB = Sequel.connect 'sqlite://test.db'
ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => "test.db"

#DB.loggers << Logger.new(STDOUT)

# Monkey patches for testing purposes
class ActiveRecord::Base
	def self.reverse col
		self.order(col => :desc)
	end
end
