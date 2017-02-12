require 'active_record'
require 'sequel'

# Database connections
DB = Sequel.connect 'sqlite://test.db'
ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => "test.db"

# Logger
if ENV['LOGGING']
	DB.loggers << Logger.new(STDOUT)
end

module Helpers
	def self.populate_database!

		DB.drop_table(:with_pk) rescue nil
		DB.create_table(:with_pk) {
			String :id, primary_key: true
			String :val
		}

		DB.drop_table(:without_pk) rescue nil
		DB.create_table(:without_pk) {
			String :id
			String :val
		}

		DB.drop_table(:empty_table) rescue nil
		DB.create_table(:empty_table) {
			String :id
			String :val
		}

		[:with_pk, :without_pk].each do |table|
			DB[table].insert(id: "5", val: "first")
			DB[table].insert(id: "2", val: "second")
			DB[table].insert(id: "6", val: "third")
		end

	end
end

# Monkey patches for testing purposes
class ActiveRecord::Base
	def self.reverse col
		self.order(col => :desc)
	end
end
