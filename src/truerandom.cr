require "./truerandom/*"

include BuildBody
include HandleResponse
include Mapping
include Prettify
include Request

module Truerandom
	struct Client
		property api_key
		alias OptionTypes = Int32 | Float32 | String | Bool

		def initialize(@api_key : String)
		end

		def integers(options = {} of String => OptionTypes)
			options = {
				"method" => "generateIntegers",
				"replacement" => true,
				"base" => 10
			}.merge(options)

			body = build_body(@api_key, options)

			request(body) do |res|
				handle_response res
			end
		end

		def integers(options = {} of String => OptionTypes)
			yield integers options
		end

		def decimal_fractions(options = {} of String => OptionTypes)
			options = {
				"method" => "generateDecimalFractions",
				"replacement" => true,
			}.merge(options)

			body = build_body(@api_key, options)

			request(body) do |res|
				handle_response res
			end
		end

		def decimal_fractions(options = {} of String => OptionTypes)
			yield decimal_fractions options
		end

		def gaussians(options = {} of String => OptionTypes)
			options = {
				"method" => "generateGaussians"
			}.merge(options)

			body = build_body(@api_key, options)

			request(body) do |res|
				handle_response res
			end
		end

		def gaussians(options = {} of String => OptionTypes)
			yield gaussians options
		end

		def strings(options = {} of String => OptionTypes)
			options = {
				"method" => "generateStrings",
				"replacement" => true
			}.merge(options)

			body = build_body(@api_key, options)

			request(body) do |res|
				handle_response res
			end
		end

		def strings(options = {} of String => OptionTypes)
			yield strings options
		end

		def uuids(options = {} of String => OptionTypes)
			options = {
				"method" => "generateUUIDs"
			}.merge(options)

			body = build_body(@api_key, options)

			request(body) do |res|
				handle_response res
			end
		end

		def uuids(options = {} of String => OptionTypes)
			yield uuids options
		end

		def blobs(options = {} of String => OptionTypes)
			options = {
				"method" => "generateBlobs",
				"format" => "base64"
			}.merge(options)

			body = build_body(@api_key, options)

			request(body) do |res|
				handle_response res
			end
		end

		def blobs(options = {} of String => OptionTypes)
			yield blobs options
		end

		def usage
			body = build_body(@api_key, {"method" => "getUsage"})

			request(body) do |res|
				if res.status_code == 200
					result = Usage.from_json(res.body).result

					{
						status: result.status,
						creation_time: result.creationTime,
						bits_left: result.bitsLeft,
						requests_left: result.requestsLeft,
						total_bits: result.totalBits,
						total_requests: result.totalRequests
					}
				else
					raise Exception.new("Something went wrong
					HTTP response code: #{res.status_code}
					see https://api.random.org/json-rpc/1/error-codes")
				end
			end
		end

		def usage
			yield usage
		end
	end
end
