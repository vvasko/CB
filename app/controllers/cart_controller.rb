class CartController < ApplicationController

  def show
    current_table = 2 #TODO: get current table

    @cocktails = {}

    @cocktails['not payed'] =
      Cocktail
         .joins(:orders)
         .includes(ordered_cocktails: [:order])
         .where("`orders`.status = ? AND `orders`.table_id = ?", Order.statuses[:pending], current_table).all_with_includes

    # .select("*,ordered_cocktails.id as ordered_cocktail_id")

    @cocktails[:payed] =
      Cocktail
        .joins(:orders)
        .includes(ordered_cocktails: [:order])
        .where("`orders`.status in(#{Order.statuses[:payed]}, #{Order.statuses[:delivered]}) AND `orders`.table_id = ?",  current_table).all_with_includes

    @currrent_table = current_table
    @cocktails

  end

  def checkout
    current_table = 2 #TODO: get current table

    Order
        .where(:table_id => current_table, :status => Order.statuses[:pending])
        .update_all(:status => Order.statuses[:payed], :sum => Order.sum_to_pay)

    redirect_to action: 'show'
  end

end
