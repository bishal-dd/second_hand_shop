require 'pry'
class Payments::PaymentsController < ApplicationController

  def index
    product_id = params[:product_id]
    @payments = Payments::Payment.joins(product: :user).where(products: { id: product_id }, status: 0)
    render json: { payments: @payments }
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

    if payment.save
      render json: { status: "success" }
    else
      render json: { status: "failed", errors: payment.errors.full_messages }
    end
  end
  private

  def payment_params
    params.require(:payment).permit(:user_id, :jrnl_no)
  end
end
