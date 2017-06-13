class InfosController < ApplicationController
  before_action :set_info, only: [:edit, :update, :index]
  before_action -> {redirect_some_path_unless_role root_path, ['admin']}, only: [:edit, :update]

  # GET /infos
  # GET /infos.json
  def index
    if /src\s*=\s*"([^"]*)"/.match(@info.google_url) == nil
      @src = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2400.5677867947065!2d18.592480115825765!3d53.01015547990988!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4703350305e6c35d%3A0xe2a77458f7322cc4!2sUniwersytet+Miko%C5%82aja+Kopernika.+Wydzia%C5%82+Matematyki+i+Informatyki!5e0!3m2!1spl!2spl!4v1492452818093"
    else
      @src = /src\s*=\s*"([^"]*)"/.match(@info.google_url)[1]
    end
    @tickets = Ticket.all
  end

  def edit
  end

  # PATCH/PUT /infos/1
  # PATCH/PUT /infos/1.json
  def update
    respond_to do |format|
      if @info.update(info_params)
        format.html { redirect_to infos_path, notice: 'Info was successfully updated.' }
        format.json { render :show, status: :ok, location: @info }
      else
        format.html { render :edit }
        format.json { render json: @info.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_info
      @info = Info.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def info_params
      params.require(:info).permit(:street, :email, :phone, :city, :zip_code, :description, :google_url, :cinema_name, :building_number,
                                   :start_mon, :start_tue, :start_wed, :start_thu, :start_fri ,:start_sat, :start_sun,
                                   :end_mon, :end_tue, :end_wed, :end_thu, :end_fri ,:end_sat, :end_sun)
    end
end
