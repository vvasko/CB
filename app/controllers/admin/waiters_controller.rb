class Admin::WaitersController < Admin::SignedApplicationController

  before_action :signed_in_user, only: [:show, :edit, :update, :index, :destroy]

  before_filter :find_item, only: [:edit, :update, :destroy, :show]


  def index
    @waiters = Waiter.all
    @worksets = Workset.all
  end

  def new
    @waiter = Waiter.new
  end

  def create
    @waiter = Waiter.create item_params
    redirect_to action: 'index'
  end

  def show
    @tables = Table.all
  end

  def edit

  end

  def destroy
    @waiter.update_attribute :status, 1
    if @waiter.errors.empty?
      flash[:success] = "Waiter #{@waiter.firstname.humanize} #{@waiter.lastname.humanize} was fired"
    else
      flash[:warning] = @waiter.errors.full_messages.to_sentence
    end
    redirect_to action: 'index'
  end

  def update
    @waiter.update_attributes item_params
    if @waiter.errors.empty?
      flash[:success] = "Waiter #{@waiter.firstname.humanize} #{@waiter.lastname.humanize} was updated successfully"
      redirect_to action: :index
    else
      flash[:warning] = @waiter.errors.full_messages.to_sentence
      render :edit
    end
  end

  def item_params
    params.require(:waiter).permit(:id, :firstname, :lastname, :photo, :status)
  end

  private
  def find_item
    @waiter = Waiter.find params[:id]
  end

end
