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
    p session[:payment_id]
    if params[:paymentId] && params[:PayerID] && params[:paymentId] == session[:payment_id]
      if PayPal::SDK::REST::Payment.find(params[:paymentId]).execute( :payer_id => params[:PayerID] )
        @order.update(approved: true, paid: true)
        p 'succes payments'
      else
        puts @payment.error # Error Hash
      end
    else
      p 'error payments'
    end
  end

  # GET /orders/new
  def new
    @order = Order.find(params[:order_id])
    @max = @order.order_seatings.count
    p ' '
    p ' '
    p ' '
    p ' '
    p ' '
    p ' '
    p ' tuuuuuuuuuuuuuuu'
    p session[:code]
    p @order.paid
    p @order.activation_code
    if session[:code] != @order.activation_code || @order.paid == true
      p 'sasasasasassa'
    end
    p ' '
    p ' '
    p ' '
    if session[:code] != @order.activation_code || @order.paid == true
      redirect_to movies_path
    end
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
    credit_card = {}
    payment_method = params[:payment_method]
    credit_card['type'] = payment_method
    if params[:credit_card]
      params[:credit_card].to_hash.each do |kay,val|
        credit_card[kay]=val
      end
    end
    hash = params[:HASH_OF_SELECTED_TICKETS]
    tmp = 0
    seating_count = @order.seatings.count
    order_id = @order.id
    items = []
    item = {}
    total = 0

    if @order.paid
      return
      redirect_to movies_path
    end

    respond_to do |format|
      if @order.update(order_params)
        Rails.logger.info '$' * 30

        if hash
          hash.to_hash.each do |key, val|
            # Rails.logger.info 'key: ' + key + ' val: ' + val
            ticket = Ticket.where(name: key).last
            # Rails.logger.info  ap ticket
            # Rails.logger.info 'ticket'
            item['name']=key
            item['sku']=key
            item['price']=format("%.2f",ticket.price)
            item['currency']='USD'
            item['quantity']=val
            items.push(item.dup)
            total = total + (ticket.price * val.to_f)
            0.upto(val.to_i - 1) do
              @order.tickets << ticket
            end
            tmp = tmp + val.to_i
          end
          if tmp!=seating_count
            @order.order_tickets.each do |val|
              val.destroy
            end
            format.json { render json: {message: 'Niewybrano biletów!'}, status: :unprocessable_entity }
          end
        else
          format.json { render json: {message: 'Niepoprawne dane biletów!'}, status: :unprocessable_entity }
        end

        Rails.logger.info items
        Rails.logger.info total
        Rails.logger.info credit_card

        if payment_method == 'paypal'
          puts 'paypal payment'
          @payment = PayPal::SDK::REST::Payment.new({
                                                        :intent =>  "sale",

                                                        # ###Payer
                                                        # A resource representing a Payer that funds a payment
                                                        # Payment Method as 'paypal'
                                                        :payer =>  {
                                                            :payment_method =>  "paypal" },

                                                        # ###Redirect URLs
                                                        :redirect_urls => {
                                                            :return_url => payment_url(@order),
                                                            :cancel_url => new_payment_url(order_id: @order.id)},

                                                        # ###Transaction
                                                        # A transaction defines the contract of a
                                                        # payment - what is the payment for and who
                                                        # is fulfilling it.
                                                        :transactions =>  [{

                                                                               # Item List
                                                                               :item_list => {
                                                                                   :items => items},

                                                                               # ###Amount
                                                                               # Let's you specify a payment amount.
                                                                               :amount =>  {
                                                                                   :total =>  format("%.2f",total),
                                                                                   :currency =>  "USD" },
                                                                               :description =>  "Opłata " + @order.name + " " + @order.surname + " " + @order.email + "." }]})

# Create Payment and return status
          if @payment.create
            # Redirect the user to given approval url
            @redirect_url = @payment.links.find{|v| v.rel == "approval_url" }.href
            logger.info "Payment[#{@payment.id}]"
            session[:payment_id] = @payment.id
            logger.info "Redirect: #{@redirect_url}"
            format.json { render json: {message: @redirect_url.to_s }, status: :ok, location: @order }
          else
            logger.error @payment.error.inspect
            format.json { render json: {message: 'Błąd połaczenia. Sprubój póżniej!'}, status: :unprocessable_entity }
          end


        else
          puts 'credit card payment'
          @payment = PayPal::SDK::REST::Payment.new({ :intent => "sale",
                                                      :payer => {
                                                          :payment_method => "credit_card",
                                                          :funding_instruments => [{
                                                                                       :credit_card => credit_card}]},
                                                      :transactions => [{
                                                                            :item_list => {
                                                                                :items => items},
                                                                            :amount => {
                                                                                :total => format("%.2f",total),
                                                                                :currency => "USD" },
                                                                            :description => "Opłata " + @order.name + " " + @order.surname + " " + @order.email + "." }]})
          if @payment.create
            logger.info "Payment[#{@payment.id}] created successfully"
            @order.update(approved: true, paid: true)
            format.json { render json: {message: "ok"}, status: :ok, location: @order }
          else
            # Display Error message
            logger.error "Error while creating payment:"
            logger.error @payment.error.inspect
            format.json { render json: {message: 'Nie poprawne dane karty kredytowej!'}, status: :unprocessable_entity }
          end
        end

      else
        format.json { render json: {message: "Nie poprawne dane zamówienia!"}, status: :unprocessable_entity }
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
