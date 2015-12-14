class Admin::WaitersController < Admin::SignedApplicationController

  before_action :signed_in_user, only: [:show, :edit, :update, :index, :destroy]

  before_filter :find_item, only: [:edit, :update, :destroy, :show, :update_tables]


  def index
    @waiters = Waiter.all
    @tables = Workset.where(status: 1).to_a.group_by { |item| item[:waiter_id] }
  end

  def new
    @waiter = Waiter.new
  end

  def create
    @waiter = Waiter.create item_params
    redirect_to action: 'index'
  end

  def show
    worksets = Workset.where(status: 1).to_a
    @tables_status = {}

    worksets.each do |item|
      if item[:waiter_id] != params[:id].to_i
        @tables_status[item[:table_id]] = 'busy'
      elsif item[:waiter_id] == params[:id].to_i
        @tables_status[item[:table_id]] = 'fixed'
      end
    end

    @tables = Table.all
    # @tables = Table.where(status: ???)

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

  def update_tables
    tables = params[:tables]
    worksets = Workset.where(waiter_id: @waiter.id, status: 1).to_a

    unless tables.nil?
      tables.each do |table|
        set = worksets.find_index { |h| h.table_id == table[0].to_i }
        if set.nil?
          create_workset(table[0], @waiter.id)
        else
          worksets.delete_at(set)
        end
      end
    end

    worksets.each do |workset|
      close_workset workset.id
    end

    flash[:success] = "Waiter #{@waiter.firstname.humanize} #{@waiter.lastname.humanize} tables was updated successfully"
    redirect_to action: :index
  end

  def create_workset (table, waiter)
    Workset.create(table_id: table, waiter_id: waiter, status: 1 )
  end

  def close_workset (id)
    Workset.find(id).update_attributes(status: 0)
  end

  def item_params
    params.require(:waiter).permit(:id, :firstname, :lastname, :photo, :status)
  end

  private
  def find_item
    @waiter = Waiter.find params[:id]
  end

end
