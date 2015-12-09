class Waiter < ActiveRecord::Base
  enum status: [ :hired, :fired]

  has_many :worksets

end
