module Sequel
	module Plugins
		module ActiveRecord
			module Last
				module DatasetMethods
					def last!(*args, &block)
					  last(*args, &block) || raise(Sequel::NoMatchingRow.new(dataset))
					end
				end
				module ClassMethods
					Sequel::Plugins.def_dataset_methods(self, :last!)
				end
			end
		end
	end
end
