require "./truerandom/*"

include BuildBody
include HandleResponse
include Request

module Truerandom
	struct Client
		property api_key
		alias OptionTypes = Int32 | Float32 | String | Bool

		def initialize(@api_key : String)
		end

		def integers(options = {} of String => OptionTypes, signed = false)
			method = "generateIntegers"
			method = "generateSignedIntegers" if signed

			options = {
				"method" => method,
				"replacement" => true,
				"base" => 10
			}.merge(options)

			body = build_body @api_key, options

			request(body) do |res|
				handle_response res, signed
			end
		end

		def integers(options = {} of String => OptionTypes, signed = false)
			yield integers options, signed
		end

		def decimal_fractions(options = {} of String => OptionTypes, signed = false)
			method = "generateDecimalFractions"
			method = "generateSignedDecimalFractions" if signed

			options = {
				"method" => method,
				"replacement" => true,
			}.merge(options)

			body = build_body @api_key, options

			request(body) do |res|
				handle_response res, signed
			end
		end

		def decimal_fractions(options = {} of String => OptionTypes, signed = false)
			yield decimal_fractions options, signed
		end

		def gaussians(options = {} of String => OptionTypes, signed = false)
			method = "generateGaussians"
			method = "generateSignedGaussians" if signed

			options = {
				"method" => method
			}.merge(options)

			body = build_body @api_key, options

			request(body) do |res|
				handle_response res, signed
			end
		end

		def gaussians(options = {} of String => OptionTypes, signed = false)
			yield gaussians options, signed
		end

		def strings(options = {} of String => OptionTypes, signed = false)
			method = "generateStrings"
			method = "generateSignedStrings" if signed

			options = {
				"method" => method,
				"replacement" => true
			}.merge(options)

			body = build_body @api_key, options

			request(body) do |res|
				handle_response res, signed
			end
		end

		def strings(options = {} of String => OptionTypes, signed = false)
			yield strings options, signed
		end

		def uuids(options = {} of String => OptionTypes, signed = false)
			method = "generateUUIDs"
			method = "generateSignedUUIDs" if signed

			options = {
				"method" => method
			}.merge(options)

			body = build_body @api_key, options

			request(body) do |res|
				handle_response res, signed
			end
		end

		def uuids(options = {} of String => OptionTypes, signed = false)
			yield uuids options, signed
		end

		def blobs(options = {} of String => OptionTypes, signed = false)
			method = "generateBlobs"
			method = "generateSignedBlobs" if signed

			options = {
				"method" => method,
				"format" => "base64"
			}.merge(options)

			body = build_body @api_key, options

			request(body) do |res|
				handle_response res, signed
			end
		end

		def blobs(options = {} of String => OptionTypes, signed = false)
			yield blobs options, signed
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
