require 'paypal-sdk-rest'
include PayPal::SDK::REST
# Build Payment object
# @payment = PayPal::SDK::REST::Payment.new({
#     :intent => "sale",
#     :payer => {
#     :payment_method => "credit_card",
#     :funding_instruments => [{
#     :credit_card => {
#     :type => "visa",
#     :number => "4063332087878016",
#     :expire_month => "11",
#     :expire_year => "2021",
#     :cvv2 => "999",
#     :first_name => "Joe",
#     :last_name => "Shopper",
#     :billing_address => {
#     :line1 => "52 N Main ST",
#     :city => "Johnstown",
#     :postal_code => "43210",
#     :country_code => "PL" }}}]},
#     :transactions => [{
#     :item_list => {
#       :items => [{
#         :name => "item",
#         :sku => "item",
#         :price => "1",
#         :currency => "USD",
#         :quantity => 1 }]},
#     :amount => {
#       :total => "1.00",
#       :currency => "USD" },
#     :description => "This is the payment transaction description." }]})
#
#
# # Create Payment and return the status(true or false)
#     if @payment.create
#       puts @payment.id     # Payment Id
#     else
#       puts @payment.error  # Error Hash
#     end

puts '%'*20
puts '%'*20
puts '#'*20
puts '#'*20

if PayPal::SDK::REST::Payment.find('PAY-2BC33614SE502615GLC6AVUI').execute( :payer_id => "RXTYXB793V82N" )
  puts '%'*20
  puts '%'*20
  puts '#'*20
  puts '#'*20
  puts 'Success Message'
  # Note that you'll need to `Payment.find` the payment again to access user info like shipping address
else
  puts '%'*20
  puts '%'*20
  puts @payment.error # Error Hash
end