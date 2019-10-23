class MoviesController < ApplicationController

    def index
      @titles = Movie.all
    end

    def show
      @movie = Movie.find(params[:id])
    end

    def edit
      @movie = Movie.find(params[:id]) 
    end

    def update
      @movie = Movie.find(params[:id]) 
        if @movie.update(movie_params)
          redirect_to @movie, notice: "Movie successfully updated!"
        else
          render :edit
        end
    end

    def new
      @movie = Movie.new
    end

    def create
      @movie = Movie.new(movie_params)
        if @movie.save
          redirect_to @movie, notice: "Movie successfully created!"
        else
          render :new
        end  
    end

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      redirect_to movies_url
    end

    
    private
    def movie_params 
      movie_params =
        params.require(:movie).
                permit(:title, :rating, :total_gross, :description, :released_on,
                :duration, :director, :image_file_name)
    end

end
