require 'pry'
class Products::ProductCategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin!, except: [:index]
  include ActionController::MimeResponds
  respond_to :json

  def index
    @product_categories = Products::ProductCategory.all
    render json: { product_categories: @product_categories }
  end

  def create
    @product_categories = Products::ProductCategory.new(product_categories_params)
    if @product_categories.save
      render json: { status: "success"}
    else
      render json: { status: "failed"}
    end
  end

  def show
    @product_categories = Products::ProductCategory.find(params[:id])
    render json: {data: @product_categories}
  end

  def update
    @product_categories = Products::ProductCategory.find(params[:id])

    if @product_categories.update(product_categories_params)
      # Handle successful update
      render json: {status: 'Product category was successfully updated.'}
    else
      # Handle update failure
      render json: {status: 'Product category was failed updated.'}
    end
  end

  def destroy
    @product_categories = Products::ProductCategory.find(params[:id])

    if @product_categories.destroy
      render json: {status: "Delete Success"}
    else
      render json: {status: "Delete Failed"}
    end
  end


  private


  def product_categories_params
    params.require(:product_categories).permit(:category)
  end
end
