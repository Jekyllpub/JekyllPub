class ArticlesController < ApplicationController
	include ArticlesHelper
	before_action :logged_in_user
	
	def index
		@articles = Article.all.reverse
	end

	def new
		@article = Article.new
		@lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
		@user = current_user.username
	end

	def create
		@article = Article.new article_params
		if @article.save # Save to the database
			redirect_to "http://jekyllpub.github.io"
			publish_post @article # Save to github
		else
			flash[:warning] = "El artículo no fue guardado"
			render 'new'
		end
	end

	def edit
		@article = Article.find params[:id]
		# predefine layout due to view conflict
		@layout = @article.layout
	end

	def update
		@article = Article.find params[:id]
		if @article.update_attributes article_params # Update the database
			redirect_to "http://jekyllpub.github.io"
			update_post @article # Update github
		else
			flash[:warning] = "El artículo no fue guardado"
			render 'edit'
		end
	end

	def destroy
		@article = Article.find params[:id]
		# Destroy article using Octokit.rb
		destroy_article @article
		# Delete article form the database
		@article.delete
	end

	private

	def article_params
		params.require(:article).permit :author, :title, :excerpt, :video,
										:category, :published, :thumbnail,
										:layout, :content
	end

	# Before filters

    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        flash.now[:alert] = "Porfavor inicia sesión"
        redirect_to root_path
      end
    end
end