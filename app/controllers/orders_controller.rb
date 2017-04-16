class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action -> {redirect_some_path_unless_roles root_path}, only: [:destroy, :index, :search, :find]

  # GET /orders
  # GET /orders.json
  def index
    if user_signed_in?
      if current_user.role == 'admin'
        @search = Order.ransack(params[:q])
        @orders = @search.result(distinct: true).includes(:seance).where(:approved => true).paginate(:page => params[:page])
      else
        @seances = Seance.seven_days_from_now
      end
    end
  end

  def search
    Rails.logger.info params.inspect
    if not params[:q][:seance_start_date_lteq].blank?
      params[:q][:seance_start_date_lteq] = params[:q][:seance_start_date_lteq].to_date.end_of_day
    end
    Rails.logger.info params.inspect
    index
    render :index
  end

  def update_ticket_type
    @order = Order.find(params[:order_id])
    Rails.logger.info params.inspect
    Rails.logger.info ap @order
    if current_user && current_user.role = 'employee'
      @order.update(approved: true)
    end

    if not @order.update(paid: true)
      respond_to do |format|
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if params[:TICKETS]
          params[:TICKETS].each do |key,val|
            ticket = Ticket.where(name: key).last
            0.upto(val.to_i - 1) do
              @order.tickets << ticket
            end
          end
          format.json { render json: {message: "ok"}, status: :ok, location: @order }
        else
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @tickets = @order.tickets
    @price = 0
    @Info = Info.find(1)
    if @tickets
      @arr = []
      @tickets.each do |x|
        @arr << { "name" => x.name, "price" => x.price }
        p x
      end
    end
  end

  def show_info
    @seance_info = Seance.find(params[:seance_id])
    room_quantity = @seance_info.room.seatings.where(slot: true).count
    current_orders = @seance_info.orders
    @current_seatings = (current_orders.map {|x| x.seatings.count}).reduce(0, :+)
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
    code = params[:c]

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

      if order && seance && code == order.activation_code
        order.approved = true
        order.save
        CinemaMailer.info_for_user(Order.find(order_id),order.list_seats.split(',')).deliver_later(wait: 1.seconds)
        @message = 'Aktywowano rezerwacje!'
      else
        @message = 'Przekroczono czas aktywacji!'
      end
    end
    puts 404404
  end

  # GET /orders/1/edit
  def edit
    if session[:code] != @order.activation_code
      redirect_to movies_path
    end
  end

  def find
    if params[:ac]
      order = Order.where(activation_code: parmas[:ac]).last
      redirect_to order_path(order_id: order.id)
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    occupied = false
    code = generate_activation_code
    session[:code] = code
    seance_id = params[:seance_id]
    if params[:ARR_OF_SELECTED_FIELDS]
      selected_fields = params[:ARR_OF_SELECTED_FIELDS].split(",")
    else
      redirect_to show_room_orders_path(seance_id: seance_id), notice: "Nie wybrano miejsca!"
    end
    if not params[:ARR_OF_SELECTED_SEATING_NUMBRE]
      return
      redirect_to show_room_orders_path(seance_id: seance_id), notice: "Błąd serwer. Sprubój później!"
    end

    if 'false' == params[:payment]
      if current_user && current_user.role = 'employee'
        order = Order.new(seance_id: seance_id,
                          name: current_user.name,
                          surname: current_user.last_name,
                          email: current_user.email,
                          paid: false,
                          approved: false,
                          reserved: false,
                          paypal: false,
                          list_seats: params[:ARR_OF_SELECTED_SEATING_NUMBRE],
                          activation_code: code
        )
      else
        order = Order.new(seance_id: seance_id,
                          name: 'Imię',
                          surname: 'Nazwisko',
                          email: 'email@przykład.pl',
                          paid: false,
                          approved: false,
                          reserved: true,
                          paypal: false,
                          list_seats: params[:ARR_OF_SELECTED_SEATING_NUMBRE],
                          activation_code: code
        )
      end
    end
    if 'true' == params[:payment]
      order = Order.new(seance_id: seance_id,
                        name: 'Imię',
                        surname: 'Nazwisko',
                        email: 'email@przykład.pl',
                        paid: false,
                        approved: false,
                        reserved: false,
                        paypal: true,
                        list_seats: params[:ARR_OF_SELECTED_SEATING_NUMBRE],
                        activation_code: code

      )
    end
    if not order.save
      redirect_to show_room_orders_path(seance_id: seance_id), notice: "Błąd serwer. Sprubój później!"
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
        order.destroy
        redirect_to show_room_orders_path(seance_id: seance_id), notice: "Przepraszamy, te miejsca zostały już zajęte!"
      else
        selected_fields.each do |id|
          order.seatings << Seating.find(id)
        end
        Approved.create(order_id: order.id)
        if 'false' == params[:payment]
          redirect_to edit_order_path(order.id)
        else
          redirect_to new_payment_path(order_id: order.id)
        end
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

    def generate_activation_code(size = 6)
      charset = %w{ 1 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
      (0...size).map{ charset.to_a[rand(charset.size)] }.join
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :surname, :email, :phone, :approved)
    end
end
