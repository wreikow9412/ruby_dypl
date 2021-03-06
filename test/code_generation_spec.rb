require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './../code_generation'

describe Model do

	it "has a method generate" do
		Model.must_respond_to("generate(file_path)")
	end


	it "creates a class from Title" do
		Model.generate.must_be_kind_of(Class) #and name of the class
	end
end
