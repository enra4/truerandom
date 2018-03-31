require "./spec_helper"

# change this value if you want to test with your own api key
API_KEY = ENV["API_KEY"]

describe Truerandom do
	truerandom = Truerandom::Client.new(API_KEY)

	describe "basic methods" do
		it "can generate integers" do
			truerandom.integers({
				"n" => 2,
				"min" => 0,
				"max" => 10
			}) do |res|
				# kind of hard to do testing with random input xd
				basic_method_testing(res)
			end
		end

		it "can generate decimal fractions" do
			truerandom.decimal_fractions({
				"n" => 2,
				"decimalPlaces" => 5
			}) do |res|
				basic_method_testing(res)
			end
		end

		it "can generate gaussians" do
			truerandom.gaussians({
				"n" => 2,
				"mean" => 0.0,
				"standardDeviation" => 1.0,
				"significantDigits" => 8
			}) do |res|
				basic_method_testing(res)
			end
		end

		it "can generate strings" do
			truerandom.strings({
				"n" => 2,
				"length" => 3,
				"characters" => "abcd"
			}) do |res|
				basic_method_testing(res)
			end
		end

		it "can generate UUIDs" do
			truerandom.uuids({"n" => 2}) do |res|
				basic_method_testing(res)
			end
		end

		it "can generate blobs" do
			truerandom.blobs({
				"n" => 2,
				"size" => 64
			}) do |res|
				basic_method_testing(res)
			end
		end

		it "can get usage" do
			usage = truerandom.usage

			usage[:status].is_a?(String).should(be_true)
			usage[:creation_time].is_a?(String).should(be_true)
			usage[:bits_left].is_a?(Int32).should(be_true)
			usage[:requests_left].is_a?(Int32).should(be_true)
			usage[:total_bits].is_a?(Int32).should(be_true)
			usage[:total_requests].is_a?(Int32).should(be_true)
		end
	end

	describe "signed methods" do
		it "can generate signed integers" do
			truerandom.integers({
				"n" => 2,
				"min" => 0,
				"max" => 10
			}, true) do |res|
				# kind of hard to do testing with random input xd
				signed_method_testing(res)
			end
		end

		it "can generate signed decimal fractions" do
			truerandom.decimal_fractions({
				"n" => 2,
				"decimalPlaces" => 5
			}, true) do |res|
				signed_method_testing(res)
			end
		end

		it "can generate signed gaussians" do
			truerandom.gaussians({
				"n" => 2,
				"mean" => 0.0,
				"standardDeviation" => 1.0,
				"significantDigits" => 8
			}, true) do |res|
				signed_method_testing(res)
			end
		end

		it "can generate signed strings" do
			truerandom.strings({
				"n" => 2,
				"length" => 3,
				"characters" => "abcd"
			}, true) do |res|
				signed_method_testing(res)
			end
		end

		it "can generate signed UUIDs" do
			truerandom.uuids({"n" => 2}, true) do |res|
				signed_method_testing(res)
			end
		end

		it "can generate signed blobs" do
			truerandom.blobs({
				"n" => 2,
				"size" => 64
			}, true) do |res|
				signed_method_testing(res)
			end
		end
	end
end

def basic_method_testing(res)
	res[:data].size.should(eq(2))
	res[:data].is_a?(Array(String)).should(be_true)
	res[:completion_time].is_a?(String).should(be_true)
	res[:bits_used].is_a?(Int32).should(be_true)
	res[:requests_left].is_a?(Int32).should(be_true)
	res[:advisory_delay].is_a?(Int32).should(be_true)
end

def signed_method_testing(res)
	basic_method_testing(res)
	res[:hashed_api_key].is_a?(String | Nil).should(be_true)
	res[:signature].is_a?(String | Nil).should(be_true)
end
