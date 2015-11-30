class Admin::ProductsController < Admin::SignedApplicationController

  before_filter :find_item, only: [:edit, :update, :destroy, :show]

  def index

    if params[:name].present?

      @products = Product.order("#{params[:name]} #{params[:direction]}").all
    else

      @products= Product.all
    end

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create item_params
    redirect_to action: 'index'
  end

  def item_params
    params.require(:product).permit(:id, :name, :image, :remove_image, :cost_price, :min_value, :product_type)

  end

  def edit

  end

  def update
    @product.update_attributes item_params
    if @product.errors.empty?
        redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to action: 'index'
  end

  def show

  end

  def search
    @products= Product.where("name LIKE ?", "%#{params[:name]}%")
  end

  private
  def find_item
    @product= Product.where(id: params[:id]).first
  end

end
