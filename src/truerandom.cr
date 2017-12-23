require "./truerandom/*"

include BuildBody
include HandleResponse
include Mapping
include Prettify
include Request

module Truerandom
	struct Client
		property api_key

		def initialize(@api_key : String)
		end

		def integers(n, min, max, replacement = true, base = 10)
			body = build_body(@api_key, {
				method: "generateIntegers",
				n: n,
				min: min,
				max: max,
				replacement: replacement,
				base: base
			})

			data_type = String
			data_type = Int32 if base == 10

			request(body) do |res|
				handle_response res
			end
		end

		def integers(n, min, max, replacement = true, base = 10)
			yield integers n, min, max, replacement, base
		end

		def decimal_fractions(n, decimal_places, replacement = true)
			body = build_body(@api_key, {
				method: "generateDecimalFractions",
				n: n,
				decimalPlaces: decimal_places,
				replacement: replacement
			})

			request(body) do |res|
				handle_response res
			end
		end

		def decimal_fractions(n, decimal_places, replacement = true)
			yield decimal_fractions n, decimal_places, replacement
		end

		def gaussians(n, mean, stdDev, sigDig)
			body = build_body(@api_key, {
				method: "generateGaussians",
				n: n,
				mean: mean,
				standardDeviation: stdDev,
				significantDigits: sigDig
			})

			request(body) do |res|
				handle_response res
			end
		end

		def gaussians(n, mean, stdDev, sigDig)
			yield gaussians n, mean, stdDev, sigDig
		end

		def strings(n, length, char, replacement = true)
			body = build_body(@api_key, {
				method: "generateStrings",
				n: n,
				length: length,
				characters: char,
				replacement: replacement
			})

			request(body) do |res|
				handle_response res
			end
		end

		def strings(n, length, char, replacement = true)
			yield strings n, length, char, replacement
		end

		def uuids(n)
			body = build_body(@api_key, {
				method: "generateUUIDs",
				n: n
			})

			request(body) do |res|
				handle_response res
			end
		end

		def uuids(n)
			yield uuids n
		end

		def blobs(n, size, forma = "base64")
			body = build_body(@api_key, {
				method: method = "generateBlobs",
				n: n,
				size: size,
				format: forma
			})

			request(body) do |res|
				handle_response res
			end
		end

		def blobs(n, size, forma = "base64")
			yield blobs n, size, forma
		end

		def usage
			body = build_body(@api_key, {method: "getUsage"})

			request(body) do |res|
				if res.status_code == 200
					result = Usage.from_json(res.body).result

					{
						status: result.status,
						creationTime: result.creationTime,
						bitsLeft: result.bitsLeft,
						requestsLeft: result.requestsLeft,
						totalBits: result.totalBits,
						totalRequests: result.totalRequests
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
