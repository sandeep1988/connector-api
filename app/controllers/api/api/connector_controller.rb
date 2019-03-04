module Api
 	module V1	
		class ConnectorController < ApplicationController
			before_action :validate_params, only: [:call_get_api]

			def validate_params
				if params[:first_req_url].blank? or  params[:second_req_url].blank?  or params[:id].blank?
					render json: {status: "error", code: 300, message: "Please enter field."} and return false
				end
			end

			def check_success_code?(code)
				return true if code == 200
			end

			def call_get_api(first_req_url= nil, second_req_url= nil, id= nil)
				result =  get_api_response(params[:first_req_url],params[:id])
				begin
					use_id = JSON.parse(result.body)["userId"]
					new_res = check_success_code?(result.code) ? get_api_response(params[:second_req_url],use_id) : result
					render json: new_res
				rescue NoMethodError => e
			   render json: {status: "error", code: 204, message: "Wrong urls"} and return false
				end		
			end

		private 
			def  get_api_response(url=nil, id=nil)
				begin
					response = HTTParty.get("#{url}/#{id}")
					return response
				rescue Exception => e
					return e
				end
			end

		# response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/42')
		# https://jsonplaceholder.typicode.com/todos/42
		end
	end
end

