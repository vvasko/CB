class Order < ActiveRecord::Base

  has_many :ordered_cocktails
  has_one :table

  enum status: [ :new, :delivered, :payed, :closed]
end
