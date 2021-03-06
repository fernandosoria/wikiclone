class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      name: "Wikiclone Membership",
      description: "Premium Membership for #{current_user.name}",
      amount: 50 
      # We're like the Snapchat for Wikipedia. But really, 
      # change this amount. Stripe won't charge $9 billion.
    }
  end

  def create

    @amount = params[:amount]

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Wikiclone Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attributes(role: 'premium')

    flash[:success] = "Thanks for upgrading your account, #{current_user.email}!"
    redirect_to user_path(current_user) # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
end