require 'spec_helper'

class FinderMethodsSpec < Minitest::Spec

	describe ":finder_methods feature" do
		before do

			Helpers.populate_database!

			@ar_model = Class.new ActiveRecord::Base do
				self.table_name = :with_pk
			end
			@plugin_model = Class.new(Sequel::Model DB[:with_pk]) do
				self.plugin :active_record, features: :finder_methods
			end

		end

		it "provides :find_by and :find_by!" do

			assert_equal 3, DB[:with_pk].count

			# Test each model
			[@ar_model, @plugin_model, @plugin_model.dataset].each do |model|

				[:find_by, :find_by!].each do |method|
					assert_equal "2", model.send(method, val: "second")[:id]
					assert_equal "5", model.send(method, dup: "shared")[:id]
					assert_equal "6", model.send(method, dup: "shared", val: "third")[:id]
					assert_raises do model.send(method, bad: "column") end
				end

				# Missing record
				assert_nil model.find_by(val: "non-existent")
				assert_raises do model.find_by!(val: "non-existent") end

			end

		end

		it "provides dynamic finders (:find_by_*)" do

			assert_equal 3, DB[:with_pk].count

			# Test each model
			[@ar_model, @plugin_model, @plugin_model.dataset].each do |model|

				# Normal invocations
				assert_equal "2", model.find_by_val("second")[:id]
				assert_equal "2", model.find_by_val!("second")[:id]
				assert_equal "5", model.find_by_dup("shared")[:id]
				assert_equal "5", model.find_by_dup!("shared")[:id]
				assert_equal "6", model.find_by_dup_and_val("shared", "third")[:id]
				assert_equal "6", model.find_by_dup_and_val!("shared", "third")[:id]
				assert_raises do model.find_by_bad("column") end
				assert_raises do model.find_by_bad!("column") end

				# Missing record
				assert_nil model.find_by_val("non-existent")
				assert_raises do model.find_by_val!("non-existent") end

				# Argument errors
				assert_raises ArgumentError do model.find_by_val() end
				assert_raises ArgumentError do model.find_by_val("1", "2") end
				assert_raises ArgumentError do model.find_by_dup_and_val() end
				assert_raises ArgumentError do model.find_by_dup_and_val("1") end
				assert_raises ArgumentError do model.find_by_dup_and_val("1", "2", "3") end

			end

		end

	end

end
