class RegulationsController < ApplicationController
  before_action :set_regulation, only: [:show, :edit, :update, :destroy]
  before_action -> {redirect_some_path_unless_role root_path, ['admin']}, only: [:edit, :update]


  # GET /regulations
  # GET /regulations.json
  def index
    @regulations = Regulation.last
  end

  # GET /regulations/1/edit
  def edit
  end

  # PATCH/PUT /regulations/1
  # PATCH/PUT /regulations/1.json
  def update
    respond_to do |format|
      if @regulation.update(regulation_params)
        format.html { redirect_to regulations_path }
        format.json { render :show, status: :ok, location: @regulation }
      else
        format.html { render :edit }
        format.json { render json: @regulation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regulation
      @regulation = Regulation.last
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regulation_params
      params.require(:regulation).permit(:regulations)
    end
end
