require 'spec_helper'

class FirstSpec < Minitest::Spec

	describe ":first feature" do
		before do
			Helpers.populate_database!
		end

		it "implicitly sorts by primary key when present" do

			assert_equal 3, DB[:with_pk].count

			ar_model = Class.new ActiveRecord::Base do
				self.table_name = :with_pk
			end
			plugin_model = Class.new(Sequel::Model DB[:with_pk]) do
				self.plugin :active_record, features: :first
			end

			# Test each model
			[ar_model, plugin_model].each do |model|

				assert_equal ["second", "first"], model.first(2).pluck(:val)
				assert_equal ["third", "first"], model.reverse(:id).first(2).pluck(:val)
				assert_equal "second", model.first[:val]

			end

		end

		it "behaves normally when primary key is not present" do

			assert_equal 3, DB[:without_pk].count

			ar_model = Class.new ActiveRecord::Base do
				self.table_name = :without_pk
			end
			plugin_model = Class.new(Sequel::Model DB[:without_pk]) do
				self.plugin :active_record, features: :first
			end
			no_plugin_model = Class.new(Sequel::Model DB[:without_pk])

			# Test each model
			[ar_model, plugin_model, no_plugin_model].each do |model|

				assert_equal ["first", "second"], model.first(2).pluck(:val)
				assert_equal ["third", "first"], model.reverse(:id).first(2).pluck(:val)
				assert_equal "first", model.first[:val]

			end

		end

	end

end
