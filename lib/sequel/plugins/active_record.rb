module Sequel
	module Plugins
		module ActiveRecord

			DEFAULT_FEATURES = [
				:first,
				:last
			].freeze

			FEATURES = Dir[File.expand_path('../', __FILE__) + "/active_record/*.rb"].map{ |f|
				File.basename(f, '.rb').to_sym
			}

			# Loads requested features as plugins on the model
			def self.configure model, features: DEFAULT_FEATURES

				features.each do |feature|

					# Sanity check the requested feature
					unless FEATURES.include? feature
						raise ArgumentError, "#{self.inspect} does not recognize feature: #{feature.inspect}"
					end

					# Load the requested feature plugins
					module_name = feature.to_s.gsub(/(^|_)(.)/){|x| x[-1..-1].upcase}
					unless self.const_defined? module_name
						require "sequel/plugins/active_record/#{feature}"
					end
					model.plugin self.const_get(module_name)

				end

			end

		end
	end
end
