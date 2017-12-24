require "./spec_helper"

API_KEY = ""

describe Truerandom do
	truerandom = Truerandom::Client.new API_KEY

	describe "basic methods" do
		it "can generate integers" do
			truerandom.integers(2, 0, 10) do |res|
				# kind of hard to do testing with random input xd
				res[:data].size.should eq 2
			end
		end

		it "can generate decimal fractions" do
			truerandom.decimal_fractions(2, 5) do |res|
				res[:data].size.should eq 2
			end
		end

		it "can generate gaussians" do
			truerandom.gaussians(2, 0.0, 1.0, 8) do |res|
				res[:data].size.should eq 2
			end
		end

		it "can generate strings" do
			truerandom.strings(2, 3, "abcd") do |res|
				res[:data].size.should eq 2
			end
		end

		it "can generate UUIDs" do
			truerandom.uuids(2) do |res|
				res[:data].size.should eq 2
			end
		end

		it "can generate blobs" do
			truerandom.blobs(2, 64) do |res|
				res[:data].size.should eq 2
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
