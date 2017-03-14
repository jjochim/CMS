class PaymentsController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.find(params[:order_id])
    @max = @order.order_seatings.count
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    Rails.logger.info '$' * 30
    Rails.logger.info params.inspect
    respond_to do |format|
      if @order.update(order_params)
        format.json { render json: {message: "ok"}, status: :ok, location: @order }
        # CinemaMailer.confirm(@order).deliver_later(wait: 1.seconds)
      else
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :surname, :email, :phone, :seance_id, :paid, :paypal, :reserved, :approved, :list_seats)
    end
end
