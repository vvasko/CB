module Employees::WaiterWorkspaceHelper


  def waiter_dropdown
    collection_select(:waiter, :id, Waiter.assigned, :id, :fullname, prompt: true)
  end

  def order_table_content_group(table, count_order_states, carrot_on_a_stick)
    " <td class='text-center'> #{table.name} </td>
                <td class='text-center'> #{alarm_button(table)} </td>
                <td class='text-center'>#{delivery_button(table.id, count_order_states[0].to_i)} </td>
                <td class='text-center'> #{payment_button(table.id,count_order_states)} </td>
                <td class='text-center'> #{clear_table_button(table,count_order_states,carrot_on_a_stick)}</td>
                <td class='text-center'> #{carrot_on_a_stick}  <span class='glyphicon glyphicon-usd'> </span></td>".html_safe

  end

  private

  def alarm_button(table)
    puts "====================start of alarm button query============================"
    if table.waiting?
      "<div class = 'btn btn-warning'> <span class='glyphicon glyphicon-bell gly-spin'> </span>
      #{link_to "alarm",employees_answer_alarm_path(:id => table.id),style: "color:inherit"}
      </div>"
    else
      "<div class = 'btn btn-info'> <span class='glyphicon glyphicon-ok'> </span>
      no need to hurry
      </div>"
    end
  end

  def delivery_button(table_id,orders)
    puts "====================start of delivery button query============================"
    if orders > 0
      "<div class = 'btn btn-warning'> <span class='glyphicon glyphicon-shopping-cart'> </span> <span class = 'badge'>#{orders} </span>
    #{link_to " not delivered",employees_status_update_path(:table_id => table_id, :status => 1),style: "color:inherit"}
      </div>"

    else
      "<div class = 'btn btn-success'> <span class='glyphicon glyphicon-ok'> </span>
      delivered
      </div>"
    end
  end

  def payment_button(table_id,orders)
    puts "====================start of payment button query============================"
    unpayed_orders = orders[0].to_i+orders[1].to_i
    if unpayed_orders > 0
      "<div class = 'btn btn-warning'> <span class='glyphicon glyphicon-usd'> </span> <span class = 'badge'>#{unpayed_orders} </span>
    #{link_to "unpayed",employees_status_update_path(:table_id => table_id, :status => 2),style: "color:inherit"}
      </div>"
    else
      "<div class = 'btn btn-success'> <span class='glyphicon glyphicon-ok'> </span>
      payed
      </div>"
    end
  end


  def clear_table_button (table,grouped_orders_count,orders_sum)
    puts "====================start of clear table button query============================"
    if table.free?
      "<div class = 'btn btn-info'> <span class='glyphicon glyphicon-ok'> </span>
      table vacant
      </div>"
    else
    if grouped_orders_count[0].blank? && grouped_orders_count[1].blank? && table.occupied?
      "<div class = 'btn btn-success'> <span class='glyphicon glyphicon-thumbs-up'> </span>
      #{link_to "clear table", employees_clear_table_path(:id => table.id,:orders_sum => orders_sum), style: "color:inherit"}
        </div>"
    else
      "<div class = 'btn btn-danger', style: 'color:inherit'> <span class='glyphicon glyphicon-hourglass'> </span>
      has active orders
      </div>"

    end
    end
  end


end
