require 'spec_helper'

class LastSpec < Minitest::Spec

	describe ":last feature" do
		before do
			Helpers.populate_database!
		end

		it "provides #last! method" do

			ar_model = Class.new ActiveRecord::Base do
				self.table_name = :with_pk
			end
			plugin_model = Class.new(Sequel::Model DB[:with_pk]) do
				self.plugin :active_record, features: :last
			end

			assert_equal 3, DB[:with_pk].count

			[ar_model, plugin_model, plugin_model.dataset].each do |model|
				assert_equal "third", model.last![:val]
			end

			[plugin_model, plugin_model.dataset].each do |model|
				assert_equal ["third", "first", "second"], model.last!(3).pluck(:val)
			end

		end

	end

end
