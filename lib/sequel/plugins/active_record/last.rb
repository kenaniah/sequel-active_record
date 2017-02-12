module Sequel
	module Plugins
		module ActiveRecord
			module Last
				def last!(*args, &block)
				  last(*args, &block) || raise(Sequel::NoMatchingRow.new(dataset))
				end
				DatasetMethods = Last
				ClassMethods = Last
			end
		end
	end
end
