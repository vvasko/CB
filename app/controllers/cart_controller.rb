class CartController < ApplicationController

  include WelcomeHelper

  before_action :get_current_table, only: [:show, :checkout]

  def show
    @cocktails = {}

    @cocktails['not payed'] =
      Cocktail
         .joins(:orders)
         .includes(ordered_cocktails: [:order])
         .where("`orders`.status = ? AND `orders`.table_id = ?", Order.statuses[:pending], @current_table).all_with_includes


    @cocktails[:payed] =
      Cocktail
        .joins(:orders)
        .includes(ordered_cocktails: [:order])
        .where("`orders`.status in(#{Order.statuses[:payed]}, #{Order.statuses[:delivered]}) AND `orders`.table_id = ?",  @current_table).all_with_includes

    @cocktails

  end

  def checkout
    Order
        .where(:table_id => @current_table, :status => Order.statuses[:pending])
        .update_all(:status => Order.statuses[:payed], :sum => Order.sum_to_pay)

    redirect_to action: 'show'
  end

  private
  def get_current_table
    @current_table = get_current_table_id
  end

end
