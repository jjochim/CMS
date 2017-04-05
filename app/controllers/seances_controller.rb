class SeancesController < ApplicationController
  before_action :set_seance, only: [:show, :edit, :update, :destroy]

  # GET /seances
  # GET /seances.json
  def index
    if current_user and current_user.role == 'admin'
    @search = Seance.search(search_params[:q])
    @seances = @search.result(distinct: true).includes(:movie, :room).paginate(:page => params[:page])
    else
      @seances = Seance.seven_days_from_now.paginate(:page => params[:page])
    end
  end

  def search
    Rails.logger.info params.inspect
    if not params[:q][:start_date_lteq].blank?
      params[:q][:start_date_lteq] = params[:q][:start_date_lteq].to_date.end_of_day
    end
    Rails.logger.info params.inspect
    index
    render :index
  end

  def show_seances_with_movie
    @movie_name = Movie.find(params[:movie_id]).title
    @seances = Seance.where(movie_id: params[:movie_id]).seven_days_from_now
    Rails.logger.info @seances_with.inspect
    respond_to do |format|
      format.html {  }
      format.json { render json:  @seances_with  }
    end
  end

  # GET /seances/1
  # GET /seances/1.json
  def show
  end

  # GET /seances/new
  def new
    @seance = Seance.new
  end

  # GET /seances/1/edit
  def edit
  end

  # POST /seances
  # POST /seances.json
  def create
    @seance = Seance.new(seance_params)
    tab = ['lector','dubbing','subtitle']
    tab.each do |val|
      if params[:rating] == val
        @seance.send((val + '=').to_sym, true)
      else
        @seance.send((val + '=').to_sym, false)
      end
    end

    respond_to do |format|
      if @seance.save
        format.html { redirect_to @seance, notice: 'Seance was successfully created.' }
        format.json { render :show, status: :created, location: @seance }
      else
        format.html { render :new }
        format.json { render json: @seance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seances/1
  # PATCH/PUT /seances/1.json
  def update
    tab = ['lector','dubbing','subtitle']
    tab.each do |val|
      if params[:rating] == val
        @seance.send((val + '=').to_sym, true)
      else
        @seance.send((val + '=').to_sym, false)
      end
    end
    respond_to do |format|
      if @seance.update(seance_params)
        format.html { redirect_to @seance, notice: 'Seance was successfully updated.' }
        format.json { render :show, status: :ok, location: @seance }
      else
        format.html { render :edit }
        format.json { render json: @seance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seances/1
  # DELETE /seances/1.json
  def destroy
    @seance.destroy
    respond_to do |format|
      format.html { redirect_to seances_url, notice: 'Seance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seance
      @seance = Seance.find(params[:id])
    end

    def search_params
      params.permit( :utf8, :commit, :page, q: [:start_date_lteq, :start_date_gteq, :movie_title_cont, :room_name_cont] ).to_h
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seance_params
      params.require(:seance).permit(:start_date, :movie_id, :room_id, :threed, :lector, :subtitle, :dubbing)
    end
end
