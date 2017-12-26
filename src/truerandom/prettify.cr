# the responses are formatted stupidly
# so this fixes that :)

module Prettify
	def prettify_regular(res)
		data = shared(res)

		{
			data: data,
			completion_time: res.result.random.completionTime,
			bits_used: res.result.bitsUsed,
			requests_left: res.result.requestsLeft,
			advisory_delay: res.result.advisoryDelay
		}
	end

	def prettify_signed(res)
		data = shared(res)

		{
			data: data,
			hashed_api_key: res.result.random.hashedApiKey,
			completion_time: res.result.random.completionTime,
			signature: res.result.signature,
			bits_used: res.result.bitsUsed,
			requests_left: res.result.requestsLeft,
			advisory_delay: res.result.advisoryDelay
		}
	end

	def shared(res)
		data = [] of String
		size = res.result.random.data.size

		size.times do |i|
			data << res.result.random.data[i].to_s
		end

		data
	end
end
