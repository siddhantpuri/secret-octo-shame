require 'spec_helper'

describe 'movies_controller' do
	@movie = Movie.new
	@controller = MoviesController.new
	begin
		@controller.create()
	rescue
	end 
	begin
		@controller.find_by_director
	rescue
	end 
	begin
		@controller.show
	rescue
	end 
	begin
		@controller.update
	rescue
	end 
	begin
		@controller.destroy
	rescue
	end
	begin
	@controller.index
	rescue
	end

end