# the responses are formatted stupidly
# so this fixes that :)

module Prettify
	def prettify(res)
		data = [] of String
		size = res.result.random.data.size

		size.times do |i|
			data << res.result.random.data[i].to_s
		end

		{
			data: data,
			completion_time: res.result.random.completionTime,
			bits_used: res.result.bitsUsed,
			requests_left: res.result.requestsLeft,
			advisory_delay: res.result.advisoryDelay
		}
	end
end
