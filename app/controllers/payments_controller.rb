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
    payment_method = params[:payment_method]
    hash = params[:HASH_OF_SELECTED_TICKETS]
    tmp = 0
    seating_count = @order.seatings.count

    respond_to do |format|
      if @order.update(order_params)
        Rails.logger.info '$' * 30

        if hash
          hash.to_hash.each do |key, val|
            Rails.logger.info 'key: ' + key + ' val: ' + val
            ticket = Ticket.where(name: key)
            Rails.logger.info  ap ticket
            Rails.logger.info 'ticket'
            0.upto(val.to_i - 1) do
              @order.tickets << ticket
            end
            tmp = tmp + val.to_i
          end
          if tmp!=seating_count
            @order.order_tickets.each do |val|
              val.destroy
            end
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        else
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end

        if payment_method == 'paypal'
          puts 'adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'
        else
          puts 'fdsagasasdgagsgasdfsaggsadfsagdfgsfadgsfdasagfd'
          # pid=Process.fork do
          #   require '././cc.rb'
          #   Process.exit
          # end
          # puts "cc.rb PID #{pid}"
          @payment = PayPal::SDK::REST::Payment.new({ :intent => "sale",

                                                      # ###Payer
                                                      # A resource representing a Payer that funds a payment
                                                      # Use the List of `FundingInstrument` and the Payment Method
                                                      # as 'credit_card'
                                                      :payer => {
                                                          :payment_method => "credit_card",

                                                          # ###FundingInstrument
                                                          # A resource representing a Payeer's funding instrument.
                                                          # Use a Payer ID (A unique identifier of the payer generated
                                                          # and provided by the facilitator. This is required when
                                                          # creating or using a tokenized funding instrument)
                                                          # and the `CreditCardDetails`
                                                          :funding_instruments => [{

                                                                                       # ###CreditCard
                                                                                       # A resource representing a credit card that can be
                                                                                       # used to fund a payment.
                                                                                       :credit_card => {
                                                                                           :type => "visa",
                                                                                           :number => "4063332087878016",
                                                                                           :expire_month => "11",
                                                                                           :expire_year => "2021",
                                                                                           :first_name => "Joee",
                                                                                           :last_name => "Shopper",}}]},
                                                      # ###Transaction
                                                      # A transaction defines the contract of a
                                                      # payment - what is the payment for and who
                                                      # is fulfilling it.
                                                      :transactions => [{

                                                                            # Item List
                                                                            :item_list => {
                                                                                :items => [{
                                                                                               :name => "item",
                                                                                               :sku => "item",
                                                                                               :price => "15",
                                                                                               :currency => "USD",
                                                                                               :quantity => 1 }]},

                                                                            # ###Amount
                                                                            # Let's you specify a payment amount.
                                                                            :amount => {
                                                                                :total => "15.00",
                                                                                :currency => "USD" },
                                                                            :description => "Test credit card payment." }]})
          if @payment.create
            logger.info "Payment[#{@payment.id}] created successfully"
          else
            # Display Error message
            logger.error "Error while creating payment:"
            logger.error @payment.error.inspect
          end
        end

        format.json { render json: {message: "ok"}, status: :ok, location: @order }
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
