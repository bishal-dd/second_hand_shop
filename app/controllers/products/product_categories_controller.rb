class Products::ProductCategoriesController < ApplicationController
  include ActionController::MimeResponds
  respond_to :json

  def new
    @product_category = Products::ProductCategory.new
  end

  def create
    @product_category = Products::ProductCategory.new(product_categories_params)
    if @product_category.save
      render json: { status: "success"}
    else
      render json: { status: "failed"}
    end
  end

  def show
    @product_category = Products::ProductCategory.find(params[:id])
    render json: {data: @product_category}
  end

  def update
    @product_category = Products::ProductCategory.find(params[:id])

    if @product_category.update(product_categories_params)
      # Handle successful update
      render json: {status: 'Product category was successfully updated.'}
    else
      # Handle update failure
      render json: {status: 'Product category was failed updated.'}
    end
  end

  def destroy
    @product_category = Products::ProductCategory.find(params[:id])

    if @product_category.destroy
      render json: {status: "Delete Success"}
    else
      render json: {status: "Delete Failed"}
    end
  end


  private

  def product_categories_params
    params.require(:product_category).permit(:category)
  end
end
