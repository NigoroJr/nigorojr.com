class ProductsController < ApplicationController
  attr_accessor :content

  def index
    @products = Product.order("created_at").reverse
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new()
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
  end

  def update
    @product = Tip.find(params[:id])
    @product.destroy();
    redirect_to :products, notice: "Deleted product"
  end
end
