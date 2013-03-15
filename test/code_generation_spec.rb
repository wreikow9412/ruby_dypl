require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './../code_generation'

describe Model do
	it "has a method generate" do
		Model.must_respond_to("generate")
	end
end
