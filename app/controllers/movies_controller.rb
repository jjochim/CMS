class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    if !params[:q].blank?
      @search = Movie.ransack(params[:q])
    else
      @search = Movie.ransack(nil)
    end
    if current_user and current_user.role == 'admin'
      @movies = @search.result(distinct: true).includes(:categories, :category_movies).paginate(:page => params[:page])
    else
      movies = $movie_front_side
      # movies = Seance.seven_days_from_now.map{|x| x.movie.id}.uniq
      @movies = @search.result(distinct: true).where(id: movies).paginate(:page => params[:page])
    end
    @premiere = Category.where(name: 'Premiera').last.movies
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @seances = Seance.where(movie_id: params[:id]).seven_days_from_now
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    @category = Category.all
  end

  # GET /movies/1/edit
  def edit
    @category
  end

  # POST /movies
  # POST /movies.json
  def create
    movie = Movie.new(movie_params)
    Rails.logger.info '#' * 30

    respond_to do |format|
      if movie.save
        format.html { redirect_to movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: movie }
      else
        format.html { render :new }
        format.json { render json: movie.errors, status: :unprocessable_entity }
        movie.delete
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    params[:movie][:category_ids] ||= []
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :duration, :genre, :pegi, :description, :director, :actors, :country,
                                    :language, :premiere, :url_trailer, :picture, :category_ids => [])
    end
end
