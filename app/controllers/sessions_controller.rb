class SessionsController < ApplicationController
	def new
		if logged_in?
			redirect_to new_article_path
		end
	end

	def create
		username = params[:session][:username]
		user = User.find_by(username: username.downcase )
		if user && user.authenticate(params[:session][:password])
			log_in(user)
			redirect_to new_article_path
		else
			flash.now[:alert] = "Combinación de nombre de usuario y correo erróneos"
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_path
	end
end
