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
end
