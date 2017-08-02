class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    value = 5

    result = Braintree::Transaction.sale(
      :amount => value, #this is currently hardcoded
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success?
      if current_user.update(money: (current_user.money + value))
        flash[:success] = "Transaction successful! 5 dollars added!"
      else
        flash[:success] = "Transaction successful but unable to update your money!"
      end
      redirect_to :root
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end
end
