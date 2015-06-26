class MoviesController < ApplicationController
	before_filter :set_filters

	def set_filters
		if not session[:ratings]
			puts "SESSION RATINGS SET BY FILTER"
			puts session[:ratings]
			session[:ratings] = {"G"=> 1, "PG"=> 1, "PG-13"=> 1, "R"=> 1} 
		end
	end

	def show
		id = params[:id] # retrieve movie ID from URI route
		@movie = Movie.find(id) # look up movie by unique ID
		# will render app/views/movies/show.<extension> by default
	end

	def index
		@all_ratings = Movie.all_ratings
		filters = []
		sort_type = params[:index]
		if not params[:ratings] then
			flash.keep
			redirect_to movies_path(:ratings => session[:ratings], :index => params[:index])
		else
			params[:ratings].each do |rating, value| filters.append(rating) end 
			if not sort_type then sort_type = session[:index] end 
			@movies = Movie.order(sort_type).where({rating: filters})
			session[:ratings] = params[:ratings]
			session[:index] = sort_type
		end
	end

	def new
		# default: render 'new' template
	end

	def create
		@movie = Movie.create!(params[:movie])
		flash[:notice] = "#{@movie.title} was successfully created."
		redirect_to movies_path
	end

	def edit
		@movie = Movie.find params[:id]
	end

	def update
		@movie = Movie.find params[:id]
		@movie.update_attributes!(params[:movie])
		flash[:notice] = "#{@movie.title} was successfully updated."
		redirect_to movie_path(@movie)
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		flash[:notice] = "Movie '#{@movie.title}' deleted."
		redirect_to movies_path
	end

	def find_by_director
		@movie = Movie.find(params[:id])
		if (not @movie.director) || (@movie.director.length < 1) then 
			flash[:notice] = "'#{@movie.title}' has no director info"
			flash.keep
			redirect_to movies_path
		else 
			@similar_director = @movie.directors
		end
	end

end
 