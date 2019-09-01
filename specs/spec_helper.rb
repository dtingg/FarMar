require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

require_relative "../far_mar"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
