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
    if user_signed_in? && current_user.role=='admin'
      @orders = @search.result(distinct: true).where(paid: false)
      @paid_orders = @search.result(distinct: true).where(paid: true)
    else
      seance = Seance.seven_days_from_now.map{|x| x.id}
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

  def show_info
    @seance_info = Seance.find(params[:seance_id])
    room_quantity = @seance_info.room.seatings.where(slot: true).count
    current_orders = @seance_info.orders
    @current_seatings = current_orders.map {|x| x.seatings}.count
    @available_seatings = room_quantity - @current_seatings
    @progress_bar = (@available_seatings * 100 / room_quantity).round

  end

  def show_room
    @seance = Seance.find(params[:seance_id])
    @seatings = Seating.where(room: @seance.room)
    @room = Room.find(@seance.room_id)
    current_orders = @seance.orders
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

  # GET /orders/new
  def new
    Rails.logger.info '$' * 30
    Rails.logger.info params.inspect
    Rails.logger.info params[:id]
    tab = Array.new
    tab = params[:ARR_OF_SELECTED_FIELDS]
    puts tab.last
    @order = Order.new

  end

  def summary
    seance_id = params[:s]
    order_id = params[:o]

    if seance_id && order_id

      begin
        order = Order.find(order_id)
      rescue ActiveRecord::RecordNotFound => e
        order = nil
      end

      begin
        seance = Seance.find(seance_id)
      rescue ActiveRecord::RecordNotFound => e
        seance = nil
      end

      if order && seance
        CinemaMailer.deliver_info_for_user(Order.find(order_id),[a2,b4])
      else
        puts 404
      end
    end
    puts 404404
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    occupied = false
    seance_id = params[:seance_id]
    selected_fields = params[:ARR_OF_SELECTED_FIELDS].split(",")

    order = Order.new(seance_id: seance_id,
                      name: 'Imię',
                      surname: 'Nazwisko',
                      email: 'email@przykład.pl',
                      phone: 'nr. tel.',
                      paid: false
    )
    if not order.save
      respond_to do |format|
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    else
      seance = Seance.find(seance_id)
      current_orders = seance.orders
      current_seatings = current_orders.map {|x| x.seatings}
      occupied_places  = []
      current_seatings.each {|seats| seats.each{ |x|  occupied_places << x.id}}
      selected_fields.each do |seat|
        if occupied_places.include?(seat.to_i)
          occupied = true
        end
      end
      if occupied
        order.delete
        redirect_to show_room_orders_path(seance_id: seance_id), notice: "Something serious happened"
      else
        selected_fields.each do |id|
          order.seatings << Seating.find(id)
        end
        redirect_to edit_order_path(order.id)
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
        CinemaMailer.confirm(@order).deliver_later(wait: 1.seconds)
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
      params.require(:order).permit(:name, :surname, :email, :phone, :seance_id, :paid, )
    end
end
