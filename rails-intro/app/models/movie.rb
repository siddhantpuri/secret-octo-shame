class Movie < ActiveRecord::Base
	has_many :theaters
	ALL_RATINGS = ['G','PG','PG-13','R']
	attr_accessible :title, :rating, :description, :release_date, :director
	def self.all_ratings
		['G','PG','PG-13','R']
	end

	def directors
		collection =  Movie.where({director: director})
	end
end
