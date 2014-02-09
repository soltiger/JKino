# encoding: utf-8

class UsersController < ApplicationController
	def new
		if admin_rights
			@user = User.new
		else
			redirect_to events_url
		end
	end
  
	def create
		if admin_rights
			@user = User.new( user_params )
			
			if @user.save
				redirect_to root_url, :notice => "Käyttäjä luotu"
			else
				render "new"
			end
		else
			redirect_to events_url
		end
	end
  
	private
		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end
end
