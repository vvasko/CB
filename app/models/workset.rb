class Workset < ActiveRecord::Base
  belongs_to :table
  belongs_to :waiter

  enum status: [ :open, :closed]
end
