class Products::ProductsController < ApplicationController
  include ActionController::MimeResponds
  respond_to :json

  def new
    @product = Products::Product.new
  end

  def create
    @product = Products::Product.new(product_params)
    if @product.save
      render json: { status: "success"}
    else
      render json: { status: "failed"}
    end
  end

  def show
    @product =  Products::Product.find(params[:id])
    render json: @product
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :image, :status, :pickup_location)
  end
end
