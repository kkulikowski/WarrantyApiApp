class WarrantiesController < ApplicationController
  before_action :set_product
  before_action :set_product_warranty, only: [:show, :update, :destroy]

  # GET /products/:product_id/warranties
  def index
    json_response(@product.warranties)
  end

  # GET /products/:product_id/warranties/:id
  def show
    json_response(@warranty)
  end

  # POST /products/:product_id/warranties
  def create
    @product.warranties.create!(warranty_params)
    json_response(@product, :created)
  end

  # PUT /products/:product_id/warranties/:id
  def update
    @warranty.update(warranty_params)
    head :no_content
  end

  # DELETE /products/:product_id/warranties/:id
  def destroy
    @warranty.destroy
    head :no_content
  end

  private

  def warranty_params
    params.permit(:name, :done)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_product_warranty
    @warranty = @product.warranties.find_by!(id: params[:id]) if @product
  end
end
