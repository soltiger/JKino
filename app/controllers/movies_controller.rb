# encoding: utf-8

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all.sort_by { |obj| obj.movie_name }
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
	if admin_rights
		@movie = Movie.new
	else
		redirect_to movies_url
	end
  end

  # GET /movies/1/edit
  def edit
  	if not admin_rights
		redirect_to movies_url
	end
  end

  # POST /movies
  # POST /movies.json
  def create
		if admin_rights
			@movie = Movie.new(movie_params)

			respond_to do |format|
			  if @movie.save
				format.html { redirect_to movies_url, notice: 'Elokuva lisätty' }
				format.json { render action: 'show', status: :created, location: @movie }
			  else
				format.html { render action: 'new' }
				format.json { render json: @movie.errors, status: :unprocessable_entity }
			  end
			end
		else
			redirect_to movies_url
		end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
	if admin_rights
		respond_to do |format|
		  if @movie.update(movie_params)
			format.html { redirect_to movies_url, notice: 'Elokuva päivitetty' }
			format.json { head :no_content }
		  else
			format.html { render action: 'edit' }
			format.json { render json: @movie.errors, status: :unprocessable_entity }
		  end
		end
	else
		redirect_to movies_url		
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
	if admin_rights
		@movie.destroy
		respond_to do |format|
		  format.html { redirect_to movies_url, notice: 'Elokuva poistettu' }
		  format.json { head :no_content }
		end
	else
		redirect_to movies_url
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:movie_name, :movie_url)
    end
end
