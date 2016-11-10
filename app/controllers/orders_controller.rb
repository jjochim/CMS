class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    params.permit(:order)
    if !params[:q].blank?
      @search = Order.ransack({params[:q].first[0] => params[:q].first[1]})
    else
      @search = Order.ransack(nil)
    end
    # Rails.logger.info '$' * 30'
    # Rails.logger.info params.inspect
    if current_user.role == 'admin'
      @orders = @search.result(distinct: true).where(paid: false)
      @paid_orders = @search.result(distinct: true).where(paid: true)
    else
      seance = Seance.seven_days_from_two_hours_ago.map{|x| x.id}
      @orders = @search.result(distinct: true).where(paid: false).where(seance_id: seance)
      @paid_orders = @search.result(distinct: true).where(paid: true).where(seance_id: seance)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @tickets = @order.tickets
    @price = 0
  end

  # GET /orders/new
  def new
    Rails.logger.info '$' * 30
    Rails.logger.info params.inspect

    @order = Order.new
    seance = Seance.find(params[:seance_id])
    @seatings = Seating.where(room: seance.room)
    @room = Room.find(seance.room_id)
    current_orders = seance.orders
    @room_quantity = @seatings.where(slot: true).count

    Rails.logger.info current_orders.inspect

    current_seatings = current_orders.map {|x| x.seatings}

    Rails.logger.info '%' * 200

    @occupied_places  = []
    current_seatings.each {|seats| seats.each{ |x|  @occupied_places << x.id}}

    @available = @room_quantity - @occupied_places.length
    Rails.logger.info @occupied_places

    @responseObject = Array[]

    (0..@room.rows-1).each do
      @responseObject.push(Array[])
    end

    (0..@room.rows-1).each do |i|
      (0..@room.columns-1).each do |j|
        if ((i)*@room.columns + (j+1) <= @room.columns * @room.rows)
          @responseObject[i].push(@seatings[((i)*@room.columns + (j+1)-1)])
        end
      end
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    Rails.logger.info '$@' * 400
    Rails.logger.info params.inspect
    Rails.logger.info '22222222'

    order = Order.new(seance_id: params[:id],
                      name: params[:name],
                      surname: params[:surname],
                      email: params[:email],
                      phone: params[:phone],
                      paid: false
    )
    if not order.save
      respond_to do |format|
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end

    if params['ARR_OF_SELECTED_FIELDS']
      params['ARR_OF_SELECTED_FIELDS'].each do |seating_id|
        order.seatings << Seating.find(seating_id)
      end
    end

    if params['HASH_OF_SELECTED_TICKETS']
      params['HASH_OF_SELECTED_TICKETS'].to_hash.each do |key, val|
        Rails.logger.info 'key: ' + key + ' val: ' + val
        ticket = Ticket.where(name: key)
        Rails.logger.info  ap ticket
        Rails.logger.info 'ticket'
        0.upto(val.to_i - 1) do
          order.tickets << ticket
        end
      end
    end
    respond_to do |format|
      if order.seatings.count == order.tickets.count and order.tickets.count > 0
        format.json { render json: {}, status: :ok}
        CinemaMailer.info_for_user(order, params['ARR_OF_SELECTED_SEATING_NUMBRE']).deliver_later(wait: 1.minutes)
      else
        format.json {render json: {}, status: :unprocessable_entity}
        order.delete
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
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
      params.require(:order).permit(:name, :surname, :email, :phone, :seance_id, :paid)
    end
end
