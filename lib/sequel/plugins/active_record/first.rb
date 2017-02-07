module Sequel
	module Plugins
		module ActiveRecord
			module First
				module DatasetMethods
					def first *args, &block
						if ds = _primary_key_order
							ds.first(*args, &block)
						else
							super
						end
					end
				end
			end
		end
	end
end
