# the responses are formatted stupidly
# so this fixes that :)

module Prettify
	def prettify(res)
		{
			data: res.result.random.data,
			completionTime: res.result.random.completionTime,
			bitsUsed: res.result.bitsUsed,
			requestsLeft: res.result.requestsLeft,
			advisoryDelay: res.result.advisoryDelay
		}
	end
end
