require "http"

module Request
	def request(body)
		yield HTTP::Client.post(
			"https://api.random.org/json-rpc/1/invoke",
			headers: HTTP::Headers{"Content-Type" => "application/json-rpc"},
			body: body
		)
	end
end
