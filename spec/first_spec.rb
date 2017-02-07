require 'spec_helper'

class FirstSpec < Minitest::Spec

	describe ":first feature" do
		before do
			@db = Sequel.connect 'sqlite://'

			@db.create_table(:with_pk){
				String :id, primary_key: true
				String :val
			}
			@db.create_table(:without_pk){
				String :id
				String :val
			}

			[:with_pk, :without_pk].each do |table|
				@db[table].insert(id: "5", val: "first")
				@db[table].insert(id: "2", val: "second")
				@db[table].insert(id: "6", val: "third")
			end

		end

		it "implicitly sorts by primary key when present" do

			assert_equal 3, @db[:with_pk].count

			# Sequel model (no implicit sorting)
			model = Sequel::Model @db[:with_pk]
			@db.loggers << Logger.new(STDOUT)
			assert_equal ["first", "second"], model.first(2).pluck(:val)
			assert_equal ["third", "first"], model.reverse(:id).first(2).pluck(:val)

			# Sequel model (with implicit sorting activated)
			model.plugin :active_record, features: :first
			assert_equal ["second", "first"], model.first(2).pluck(:val)
			assert_equal ["third", "first"], model.reverse(:id).first(2).pluck(:val)

		end

		it "behaves normally when primary key is not present" do

			assert_equal 3, @db[:without_pk].count

			# Sequel model (no implicit sorting)
			model = Sequel::Model @db[:without_pk]
			@db.loggers << Logger.new(STDOUT)
			assert_equal ["first", "second"], model.first(2).pluck(:val)
			assert_equal ["third", "first"], model.reverse(:id).first(2).pluck(:val)

			# Sequel model (with implicit sorting activated)
			model.plugin :active_record, features: :first
			assert_equal ["first", "second"], model.first(2).pluck(:val)
			assert_equal ["third", "first"], model.reverse(:id).first(2).pluck(:val)

		end

	end

end
