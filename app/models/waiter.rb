class Waiter < ActiveRecord::Base
  enum status: [ :hired, :fired]

  has_many :worksets

  def fullname
    "#{firstname} #{lastname}"
  end

  def waiters_share
    0.05
  end

end
