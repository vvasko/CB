class Admin::TablesController < Admin::SignedApplicationController
  before_action :item_params, only: []

  def index

  end

  def new
    @table = Table.new
  end

  def create
    @table = Table.create items_params
    if @table.errors.empty?
      flash[:success] = "Table \'#{@table.name.humanize}\' added successfully'"
      redirect_to action: :index
    else
      flash[:warning] = @table.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit

  end

  def update

  end

  def items_params
    params.require(:table).permit(:id, :name)
  end
end
