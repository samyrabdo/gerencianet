
class PaymentsController < ApplicationController

# POST /payments
# POST /payments.json
def create

require "gerencianet"
require "date"
 tomorrow = Date.today + 1


options = {
client_id: "minhaChave",
client_secret: "minhaChave",
  sandbox: true
}
 
charge = {
  items: [{
    name: "Product 1",
    value: 1000,
    amount: 2
  }],
  shippings: [{
    name: "Default Shipping Cost",
    value: 100
  }, {
    name: "Adicional Shipping Cost",
    value: 150
  }]
}
 
payment = {
  payment: {
     banking_billet: {
      expire_at: tomorrow.strftime,
      customer: {
        name: "Gorbadoc Oldbuck",
        email: "oldbuck@gerencianet.com.br",
        cpf: "94271564656",
        birth: "1977-01-15",
        phone_number: "5144916523"
      }
    }
  }
}
 
gerencianet = Gerencianet.new(options)
 
charge = gerencianet.create_charge(body: charge)
 
params = {
  id: charge["data"]["charge_id"]
}
 
render json: gerencianet.pay_charge(params: params, body: payment)

end

end
