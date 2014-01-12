# encoding: utf-8

class UsersController < ApplicationController
  def new
	@user = User.new
  end
  
  def create
		if admin_rights
			@user = User.new( user_params )
				if @user.save
				redirect_to root_url, :notice => "Käyttäjä luotu"
			else
				render "new"
			end
	  end
	end
  
	private
		def user_params
			params.require(:user).permit(:username, :password, :password_confirmation)
		end
end
