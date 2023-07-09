require 'pry'
class Payments::PaymentsController < ApplicationController

  def index
    user = User.find(params[:id])
    products = Products::Product.where(user_id: user.id)

    if products.empty?
      render json: { error: "No products found for the user" }, status: :not_found
      return
    end

    product_ids = products.pluck(:id)
    @payments= Payments::Payment.where(product_id: product_ids).joins(:product).select('payments.id, payments.amount, payments.jrnl_no, products.name, products.price  ')

    render json: { payments_and_product: @payments}
  end


  def payment
    product = Products::Product.find(params[:id])
    payment_amount = product.price

    @payment = Payments::Payment.new(payment_params)
    @payment.amount = payment_amount
    @payment.product_id = params[:id]

    if @payment.save
      render json: { status: "success" }
    else
      render json: { status: "failed", errors: @payment.errors.full_messages}
    end
  end

  def payment_approval
    payment = Payments::Payment.find(params[:id])
    payment.status = 1
    product = Products::Product.find(payment.product_id) # Assuming there is a foreign key association between Payment and Product
    product.status = 1 # Assuming there is a 'status' attribute in the Product model
    if payment.save && product.save
      render json: { status: "success" }
    else
      render json: { status: "failed", errors: [payment.errors.full_messages, product.errors.full_messages].flatten }
    end
  end

  def total_payment_amount
    user = User.find(params[:user_id])
    payment = Payments::Payment.where(user_id: user.id)
    total_amount = payment.sum(:amount)
    render json: { total_amount: total_amount }
  end


  private

  def payment_params
    params.require(:payment).permit(:user_id, :jrnl_no)
  end
end
