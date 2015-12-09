class Order < ActiveRecord::Base

  has_many :ordered_cocktails
  belongs_to :table

  enum status: [ :new, :delivered, :payed, :closed]
end
