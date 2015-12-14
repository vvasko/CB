class Employees::WaiterWorkspaceController < Employees::EmployeesApplicationController


  def index
    puts '====================start of index query============================'
    #@waiter = Waiter.includes(worksets: [{table: [:orders]}]).find_by_id(params[:id])
    @waiter = select_waiter(params[:id])
    if @waiter
    @worksets = select_worksets_with_table(params[:id])
    end
    puts '====================end of index query============================'


  end

  def answer_alarm
    update_status(Table,params[:id],1)
    flash[:success] = 'Now go, check what they want'
    redirect_to_waiter
  end

  def clear_table
    update_status(Table,params[:id],0)
    order_status_shift(params[:id],3)
    payout(params[:id])
    flash[:success] = 'Table was cleared successfully'
    redirect_to_waiter
  end

  def status_update
    #Order.where(table_id: params[:table_id]).where(status: required_status).update_all(status: params[:status])
    order_status_shift(params[:table_id],params[:status])
    redirect_to_waiter
  end

  def redirect_to_waiter
    redirect_to request.referer.blank? ? root_url : request.referer
  end
  private

  def order_status_shift(table_id,status)
    Order.where(table_id: table_id).where(status: required_status(status)).update_all(status: status)
  end

  def required_status(status)
    status.to_i-1
  end

  def payout(table_id)
    workset = Workset.includes(table: [:orders]).find_by(table_id: table_id,status: 'open')
    workset.update(total_earned: workset.carrot_on_a_stick('='))
  end

  def update_status(object,id,status)
    object.update(id,status: status)
  end
  def select_worksets_with_table(id)
    Workset.includes(:table).where(waiter_id: id).open
   # Workset.joins(:orders).includes(table:[:orders]).where(waiter_id: id).open.distinct
  end

  def select_waiter(id)
    Waiter.find_by_id(id)
  end

end
