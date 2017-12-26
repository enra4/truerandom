require "./mapping"
require "./prettify"

include Mapping
include Prettify

module HandleResponse
	def handle_response(res, signed)
		if res.status_code == 200
			if signed
				prettify_signed(SignedResponse.from_json(res.body))
			else
				prettify_regular(Response.from_json(res.body))
			end
		else
			raise Exception.new("Something went wrong
			HTTP response code: #{res.status_code}
			see https://api.random.org/json-rpc/1/error-codes")
		end
	end
end
