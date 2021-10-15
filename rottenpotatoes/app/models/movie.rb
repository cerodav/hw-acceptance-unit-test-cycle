class Movie < ActiveRecord::Base
    def self.movies_with_same_director movie_title
        director = Movie.find_by(title: movie_title).director
        if (!director.nil? and !director.empty?)
            return Movie.where(director: director).where.not(title: movie_title).all
        else
            return []
        end
    end
end
