require "json"

# builds bodies for the http requests before they are sent
module BuildBody
	def build_body(api_key, tuple)
		JSON.build do |json|
			json.object do
				json.field "jsonrpc", "2.0"
				json.field "method", tuple[:method]
				json.field "params" do
					json.object do
						json.field "apiKey", api_key

						tuple.each do |param, value|
							json.field param, value unless param == :method
						end
					end
				end

				json.field "id", 666 # this field is useless btw
			end
		end
	end
end
