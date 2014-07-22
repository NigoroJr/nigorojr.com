class ProductsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def index
    @products = Product.order("created_at").reverse
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params[:id])
    if @product.save
      redirect_to @product, notice: "Added product"
    else
      render "new"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to :products, notice: "Deleted product"
  end

  def update
    @product = Product.find(params[:id])
    @product.assign_attributes(params[:product])
    if @product.save
      redirect_to @product, notice: "Updated product"
    else
      render "edit"
    end
  end
end
