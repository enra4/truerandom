require "./spec_helper"

API_KEY = ""

describe Truerandom do
	truerandom = Truerandom::Client.new API_KEY

	describe "basic methods" do
		it "can generate integers" do
			truerandom.integers({
				"n" => 2,
				"min" => 0,
				"max" => 10
			}) do |res|
				# kind of hard to do testing with random input xd
				basic_method_testing res
			end
		end

		it "can generate decimal fractions" do
			truerandom.decimal_fractions({
				"n" => 2,
				"decimalPlaces" => 5
			}) do |res|
				basic_method_testing res
			end
		end

		it "can generate gaussians" do
			truerandom.gaussians({
				"n" => 2,
				"mean" => 0.0,
				"standardDeviation" => 1.0,
				"significantDigits" => 8
			}) do |res|
				basic_method_testing res
			end
		end

		it "can generate strings" do
			truerandom.strings({
				"n" => 2,
				"length" => 3,
				"characters" => "abcd"
			}) do |res|
				basic_method_testing res
			end
		end

		it "can generate UUIDs" do
			truerandom.uuids({"n" => 2}) do |res|
				basic_method_testing res
			end
		end

		it "can generate blobs" do
			truerandom.blobs({
				"n" => 2,
				"size" => 64
			}) do |res|
				basic_method_testing res
			end
		end

		it "can get usage" do
			usage = truerandom.usage

			usage[:status].is_a?(String).should eq true
			usage[:creation_time].is_a?(String).should eq true
			usage[:bits_left].is_a?(Int32).should eq true
			usage[:requests_left].is_a?(Int32).should eq true
			usage[:total_bits].is_a?(Int32).should eq true
			usage[:total_requests].is_a?(Int32).should eq true
		end
	end
end

def basic_method_testing(res)
	res[:data].size.should eq 2
	typeof(res[:data]).should eq Array(String)
	typeof(res[:completion_time]).should eq String
	typeof(res[:bits_used]).should eq Int32
	typeof(res[:requests_left]).should eq Int32
	typeof(res[:advisory_delay]).should eq Int32
end
