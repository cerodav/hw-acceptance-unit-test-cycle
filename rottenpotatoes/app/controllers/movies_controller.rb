class MoviesController < ApplicationController

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def index
    @movies = Movie.all
  end
  
  def similar_movies
    id = params[:id]
    @current_movie = Movie.find(id)
    if (!@current_movie.director.nil? and !@current_movie.director.empty?) then
      @movies = Movie.movies_with_same_director(@current_movie.title)
    else
      flash[:notice] = "'#{@current_movie.title}' has no director info"
      redirect_to movies_path
    end
  end

  def new
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
