require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/reporters'
require 'minitest/spec'
require 'sequel'
require_relative '_init.rb'

# Improved Minitest output (color and progress bar)
Minitest::Reporters.use!(
	[Minitest::Reporters::SpecReporter.new],
	ENV,
	Minitest.backtrace_filter
)
