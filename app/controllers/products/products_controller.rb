class Products::ProductsController < ApplicationController
  include ActionController::MimeResponds
  respond_to :json

  def index
    @products = Products::Products
                  .joins(:product_categories, :product_sizes)
                  .select('products.id, products.name, product_categories.category, product_sizes.size')
                  .all

    render json: { products: @products }
  end

  def create
    # Retrieve the relevant data from their respective tables
    product_category = Products::ProductCategories.find_by(category: params[:product][:product_categories])
    product_size = Products::ProductSizes.find_by(size: params[:product][:product_sizes])
    # Create the product with the matched IDs
    @product = Products::Products.new(product_params)
    @product.product_categories_id = product_category.id if product_category
    @product.product_sizes_id = product_size.id if product_size

    if @product.save
      render json: { status: "success"}
    else
      render json: { status: "failed"}
    end
  end

  def show
    @product =  Products::Products.find(params[:id])
    render json: {product: @product}
  end

  private

  def product_params
    params.require(:product).permit(:name, :user_id, :price, :image, :status, :pickup_location)
  end
end
