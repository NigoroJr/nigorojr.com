class ProductsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def index
    @products = Product.order("created_at DESC")
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])

    # Don't allow editing someone else's post
    if !@logged_in_as.can_modify(@product)
      raise Forbidden
    end
  end

  def create
    attributes = params.require(:product).permit(:name, :description, :website, :category, :team, :updated, :version)
    @product = Product.new(attributes)
    @product.posted_by = @logged_in_as.username

    if @product.save
      flash[:notice] = "Added product"
      redirect_to products_path
    else
      render "new"
    end
  end

  def update
    attributes = params.require(:product).permit(:name, :description, :website, :category, :team, :updated, :version)
    @product = Product.find(params[:id])
    @product.assign_attributes(attributes)
    @product.posted_by = @logged_in_as.username

    if @product.save
      flash[:notice] = "Updated product"
      redirect_to products_path
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])

    # Don't delete someone else's post
    if !@logged_in_as.can_modify(@product)
      raise Forbidden
    end

    @product.destroy
    flash[:notice] = "Deleted product"
    redirect_to :products
  end
end
