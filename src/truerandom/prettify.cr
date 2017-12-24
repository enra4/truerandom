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
			completionTime: res.result.random.completionTime,
			bitsUsed: res.result.bitsUsed,
			requestsLeft: res.result.requestsLeft,
			advisoryDelay: res.result.advisoryDelay
		}
	end
end
