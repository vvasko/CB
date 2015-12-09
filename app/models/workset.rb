class Workset < ActiveRecord::Base
  has_one :table
  has_one :waiter

  enum status: [ :open, :closed]
end
