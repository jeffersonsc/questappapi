module Authenticable
	#Overwrites devise method current user
	def current_user
		puts "MODULE CALLBACK"
		@current_user ||= User.find_by(auth_token: request.headers['Authorization'])
	end

	def request
		request
	end
end