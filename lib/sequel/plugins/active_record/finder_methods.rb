module Sequel
	module Plugins
		module ActiveRecord
			module FinderMethods

				# Implements find_by methods
				def method_missing(name, *args, **kwargs, &block)

					strict = name.to_s.ends_with?("!")

					case name

					# Emulate find_by
					when :find_by, :find_by!
						dataset = self.where(*args)
						result = dataset.[](**kwargs)
						raise Sequel::NoMatchingRow.new(dataset) if strict && !result
						result

					# Emulate dynamic finders
					when /^find_by_/
						terms = name.to_s.sub("find_by_", "").chomp("!").split("_and_").map(&:to_sym)
						raise ::ArgumentError, "wrong number of arguments (given #{args.count}, expected #{terms.count})" unless args.count == terms.count
						dataset = self.where(terms.zip(args).to_h)
						result = dataset.first
						raise Sequel::NoMatchingRow.new(dataset) if strict && !result
						result

					# Move up the chain
					else
						super
					end

				end

				DatasetMethods = FinderMethods
				ClassMethods = FinderMethods

			end
		end
	end
end
