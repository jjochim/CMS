class OrderSeatingsController < ApplicationController
  before_action :set_order_seating, only: [:show, :edit, :update, :destroy]

  # GET /order_seatings
  # GET /order_seatings.json
  def index
    @order_seatings = OrderSeating.all
  end

  # GET /order_seatings/1
  # GET /order_seatings/1.json
  def show
  end

  # GET /order_seatings/new
  def new
    @order_seating = OrderSeating.new
  end

  # GET /order_seatings/1/edit
  def edit
  end

  # POST /order_seatings
  # POST /order_seatings.json
  def create
    @order_seating = OrderSeating.new(order_seating_params)

    respond_to do |format|
      if @order_seating.save
        format.html { redirect_to @order_seating, notice: 'Order seating was successfully created.' }
        format.json { render :show, status: :created, location: @order_seating }
      else
        format.html { render :new }
        format.json { render json: @order_seating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_seatings/1
  # PATCH/PUT /order_seatings/1.json
  def update
    respond_to do |format|
      if @order_seating.update(order_seating_params)
        format.html { redirect_to @order_seating, notice: 'Order seating was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_seating }
      else
        format.html { render :edit }
        format.json { render json: @order_seating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_seatings/1
  # DELETE /order_seatings/1.json
  def destroy
    @order_seating.destroy
    respond_to do |format|
      format.html { redirect_to order_seatings_url, notice: 'Order seating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_seating
      @order_seating = OrderSeating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_seating_params
      params.require(:order_seating).permit(:seating_id, :order_id, :ticked_id)
    end
end
