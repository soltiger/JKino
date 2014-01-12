# encoding: utf-8

class SessionsController < ApplicationController
  def new
  end
  
  def create
	user = User.authenticate( params[:username], params[:password] )
	
	if user
		session[:user_id] = user.id
		redirect_to root_url, :notice => "Kirjautuminen onnistui"
	else
		flash.now.alert = "Väärä käyttäjänimi tai salasana"
		render "new"
	end
  end
  
  def destroy
	session[:user_id] = nil
	redirect_to root_url, :notice => "Kirjauduit ulos"
  end
end
