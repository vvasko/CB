class Order < ActiveRecord::Base

  has_many :ordered_cocktails
  belongs_to :table

  scope :uncleared, -> {where("status < 3 ")}

  enum status: [ :pending, :delivered, :payed, :closed] #rails wasn't all that thrilled about :new, with it being default action, and stuff. So I changed it to :pending
end
