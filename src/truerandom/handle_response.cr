module HandleResponse
	def handle_response(res)
		if res.status_code == 200
			prettify(Response.from_json(res.body))
		else
			raise Exception.new("Something went wrong
			HTTP response code: #{res.status_code}
			see https://api.random.org/json-rpc/1/error-codes")
		end
	end
end
