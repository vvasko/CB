class Order < ActiveRecord::Base

  has_many :ordered_cocktails
  has_many :cocktails, through: :ordered_cocktails
  belongs_to :table

  enum status: [ :pending, :delivered, :payed, :closed] #rails wasn't all that trilled about :new, with it being default action, and stuff. So I changed it to :pending


  def self.add_cocktail_to_order cocktail_id

    current_table = 2 #TODO: get current table
    order = Order.find_or_create_by(:status => Order.statuses[:pending], :table_id => current_table)

    OrderedCocktail.create(order_id: order.id, cocktail_id: cocktail_id)

  end


end
