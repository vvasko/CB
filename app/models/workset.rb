class Workset < ActiveRecord::Base
  belongs_to :table
  belongs_to :waiter
  has_many :orders, through: :table

  enum status: [ :open, :closed]


  @@waiters_share = 0.05 # probably should be adjustable, and thus a part of waiter model/table instead, but oh well

  def carrot_on_a_stick(query = '<')
    table.orders.where("status #{query} ?",3).sum(:sum)*@@waiters_share
  end


  def count_order_states
    table.orders.group(:status).count
  end
end
