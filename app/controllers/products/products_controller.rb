class Products::ProductsController < ApplicationController
  include ActionController::MimeResponds
  respond_to :json
  def index
    name = params[:name]
    category = params[:category]

    @products = Products::Products
                  .joins(:product_categories, :product_sizes)
                  .select('products.id, products.name, products.price, products.pickup_location, products.status, product_categories.category, product_sizes.size')

    # Filter the products by name if it is provided
    if name.present?
      @products = @products.where(products: { name: name })
    end

    # Filter the products by category if it is provided
    if params[:category].present?
      @products = @products.where("product_categories.category = ?", params[:category])
    end

    products_with_image_data = @products.map do |product|
      product_attributes = product.attributes
      if product.image.attached?
        product_attributes['image_url'] = url_for(product.image)
      end
      product_attributes
    end

    render json: { products: products_with_image_data }
  end

  def create
    # Retrieve the relevant data from their respective tables
    product_category = Products::ProductCategories.find_by(category: params[:category])
    product_size = Products::ProductSizes.find_by(size: params[:size])
    # Create the product with the matched IDs
    @product = Products::Products.new(product_params)
    @product.product_categories_id = product_category.id if product_category
    @product.product_sizes_id = product_size.id if product_size

    uploaded_image = params[:image]
    if uploaded_image
      @product.image.attach(uploaded_image)
    end

    if @product.save
      render json: { status: "success"}
    else
      render json: { status: "failed"}
    end
  end

  def show
    @product = Products::Products.find(params[:id])

    product = @product.attributes
    if @product.image.attached?
      product['image_url'] = url_for(@product.image)
    end

    render json: { product: product}
  end

  def user_products
    user_id = params[:user_id]
    status = params[:status]

    @user_products = Products::Products
                       .joins(:product_categories, :product_sizes)
                       .where(user_id: user_id)
                       .select('products.id, products.name, products.price, products.pickup_location, products.status, product_categories.category, product_sizes.size')

    # Filter the products by status if it is provided
    if status.present?
      @user_products = @user_products.where(products: { status: status })
    end

    products_with_image_data = @user_products.map do |product|
      product_attributes = product.attributes
      if product.image.attached?
        product_attributes['image_url'] = url_for(product.image)
      end
      product_attributes
    end

    render json: { products: products_with_image_data }
  end


  def destroy
    @product = Products::Products.find(params[:id])
    if @product.destroy
      render json: { status: "delete success" }
    else
      render json: { status: "delete failed" }
    end
  end

  def update
    @product = Products::Products.find(params[:id])

    # Retrieve the relevant data from their respective tables
    product_category = Products::ProductCategories.find_by(category: params[:category])
    product_size = Products::ProductSizes.find_by(size: params[:size])

    # Update the product with the matched IDs
    @product.product_categories_id = product_category.id if product_category
    @product.product_sizes_id = product_size.id if product_size

    uploaded_image = params[:image]
    if uploaded_image
      @product.image.attach(uploaded_image)
    end

    if @product.update(product_params)
      render json: { status: "edit success"}
    else
      render json: { status: "edit failed"}
    end
  end

  private

  # def product_params
  #   params.require(:product).permit(:name, :user_id, :price, :status, :pickup_location)
  # end

  #just for test purposes
  def product_params
      params.permit(:name, :user_id, :price, :status, :pickup_location, :image)
  end

end
