class InfosController < ApplicationController
  before_action :set_info, only: [:show, :edit, :update, :destroy]
  before_action -> {redirect_some_path_unless_role root_path, 'admin'}, only: :edit

  # GET /infos
  # GET /infos.json
  def index
    @info = Info.last
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
      params.require(:info).permit(:street, :email, :phone, :city, :zip_code, :description, :google_url, :cinema_name, :building_number)
    end
end
