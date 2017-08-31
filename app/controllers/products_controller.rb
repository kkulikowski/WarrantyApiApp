class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # Get /products
  def index
    @products = current_user.products
    json_response(@products)
  end

  # POST /products
  def create
    # create! instead of create because
    # This way, the model will raise an exception ActiveRecord::RecordInvalid. 
    # This way, we can avoid deep nested if statements in the controller.
    # Thus, we rescue from this exception in the ExceptionHandler module.
    @product = current_user.products.create!(product_params)
    json_response(@product, :created)
  end

  # GET /products/:id
  def show
    json_response(@product)
  end

  # PUT /products/:id
  def update
    @product.update(product_params)
    head :no_content
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product_params
    # whitelist params
    params.permit(:title)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
