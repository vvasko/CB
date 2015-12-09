class Table < ActiveRecord::Base
  has_many :orders
  has_many :worksets

  enum status: [ :free, :occupied, :inactive, :waiting]

end
