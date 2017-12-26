require "json"

# handles mapping for the http response
# so that the types in the response are all nice
module Mapping
	struct Response
		JSON.mapping(
			jsonrpc: String,
			result: {type: Result},
			id: Int32
		)
	end

	struct Result
		JSON.mapping(
			random: {type: Rndm},
			bitsUsed: Int32,
			bitsLeft: Int32,
			requestsLeft: Int32,
			advisoryDelay: Int32
		)
	end

	struct Rndm
		JSON.mapping(
			data: Array(Int32 | Float32 | String),
			completionTime: String
		)
	end

	# the response from getUsage looks different than the other ones
	struct Usage
		JSON.mapping(
			jsonrpc: String,
			result: {type: UsageRes},
			id: Int32
		)
	end

	struct UsageRes
		JSON.mapping(
			status: String,
			creationTime: String,
			bitsLeft: Int32,
			requestsLeft: Int32,
			totalBits: Int32,
			totalRequests: Int32
		)
	end

	struct SignedResponse
		JSON.mapping(
			jsonrpc: String,
			result: {type: SignedResult},
			id: Int32
		)
	end

	struct SignedResult
		JSON.mapping(
			random: {type: SignedRndm},
			signature: String,
			bitsUsed: Int32,
			bitsLeft: Int32,
			requestsLeft: Int32,
			advisoryDelay: Int32
		)
	end

	struct SignedRndm
		JSON.mapping(
			method: String,
			hashedApiKey: String,
			n: Int32,
			min: Int32 | Float32 | Nil,
			max: Int32 | Float32 | Nil,
			decimalPlaces: Int32 | Float32 | Nil,
			mean: Int32 | Float32 | Nil,
			standardDeviation: Int32 | Float32 | Nil,
			significantDigits: Int32 | Float32 | Nil,
			length: Int32 | Nil,
			characters: String | Nil,
			size: Int32 | Nil,
			format: String | Nil,
			replacement: Bool | Nil,
			base: Int32 | Nil,
			data: Array(Int32 | Float32 | String),
			completionTime: String,
			serialNumber: Int32
		)
	end
end
