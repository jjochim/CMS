class CategoryMoviesController < ApplicationController
  before_action :set_category_movie, only: [:show, :edit, :update, :destroy]

  # GET /category_movies
  # GET /category_movies.json
  def index
    @category_movies = CategoryMovie.all
  end

  # GET /category_movies/1
  # GET /category_movies/1.json
  def show
  end

  # GET /category_movies/new
  def new
    @category_movie = CategoryMovie.new
  end

  # GET /category_movies/1/edit
  def edit
  end

  # POST /category_movies
  # POST /category_movies.json
  def create
    @category_movie = CategoryMovie.new(category_movie_params)

    respond_to do |format|
      if @category_movie.save
        format.html { redirect_to @category_movie, notice: 'Category movie was successfully created.' }
        format.json { render :show, status: :created, location: @category_movie }
      else
        format.html { render :new }
        format.json { render json: @category_movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_movies/1
  # PATCH/PUT /category_movies/1.json
  def update
    respond_to do |format|
      if @category_movie.update(category_movie_params)
        format.html { redirect_to @category_movie, notice: 'Category movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @category_movie }
      else
        format.html { render :edit }
        format.json { render json: @category_movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_movies/1
  # DELETE /category_movies/1.json
  def destroy
    @category_movie.destroy
    respond_to do |format|
      format.html { redirect_to category_movies_url, notice: 'Category movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_movie
      @category_movie = CategoryMovie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_movie_params
      params.require(:category_movie).permit(:category_id, :movie_id)
    end
end
