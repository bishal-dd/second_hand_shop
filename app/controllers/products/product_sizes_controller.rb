class Products::ProductSizesController < ApplicationController
  include ActionController::MimeResponds
  respond_to :json

  def index
    @product_sizes = Products::ProductSize.all
    render json: {product_sizes: @product_sizes}
  end


  def create
    @product_sizes = Products::ProductSize.new(product_sizes_params)
    if @product_sizes.save
      render json: { status: "success"}
    else
      render json: { status: "failed"}
    end
  end

  def show
    @product_sizes = Products::ProductSize.find(params[:id])
    render json: {data: @product_sizes}
  end

  def update
    @product_sizes = Products::ProductSize.find(params[:id])

    if @product_sizes.update(product_sizes_params)
      # Handle successful update
      render json: {status: 'Product size was successfully updated.'}
    else
      # Handle update failure
      render json: {status: 'Product size was failed updated.'}
    end
  end

  def destroy
    @product_sizes = Products::ProductSize.find(params[:id])

    if @product_sizes.destroy
      render json: {status: "Delete Success"}
    else
      render json: {status: "Delete Failed"}
    end
  end


  private

  def product_sizes_params
    params.require(:product_sizes).permit(:size)
  end
end
