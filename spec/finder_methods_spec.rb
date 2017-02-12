require 'spec_helper'

class FinderMethodsSpec < Minitest::Spec

	describe ":finder_methods feature" do
		before do
			Helpers.populate_database!
		end

		it "provides :find_by / :find_by!" do

			assert_equal 3, DB[:with_pk].count

			ar_model = Class.new ActiveRecord::Base do
				self.table_name = :with_pk
			end
			plugin_model = Class.new(Sequel::Model DB[:with_pk]) do
				self.plugin :active_record, features: :finder_methods
			end

			# Test each model
			[ar_model, plugin_model, plugin_model.dataset].each do |model|

				[:find_by, :find_by!].each do |method|
					assert_equal "2", model.send(method, val: "second")[:id]
					assert_equal "5", model.send(method, dup: "shared")[:id]
					assert_equal "6", model.send(method, dup: "shared", val: "third")[:id]
					assert_raises do model.send(method, bad: "column") end
				end

				# missing record
				assert_nil model.find_by(val: "non-existent")
				assert_raises do model.find_by!(val: "non-existent") end

			end

		end

	end

end
