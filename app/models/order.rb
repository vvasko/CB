class Order < ActiveRecord::Base

  has_many :ordered_cocktails
  belongs_to :table

  enum status: [ :pending, :delivered, :payed, :closed] #rails wasn't all that trilled about :new, with it being default action, and stuff. So I changed it to :pending
end
