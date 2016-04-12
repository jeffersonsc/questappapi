module Authenticable
	#Overwrites devise method current user
	def current_user
		puts "MODULE CALLBACK"
		@current_user ||= User.find_by(auth_token: request.headers['Authorization'])
	end

	def authenticate_with_token!
		render json: {errors: "Not authenticated"} , status: 401 unless current_user.present?
	end

	def request
		request
	end

	def response
		response
	end
end