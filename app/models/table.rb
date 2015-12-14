class Table < ActiveRecord::Base
  has_many :orders
  has_many :worksets

  enum status: [:free, :occupied, :inactive, :waiting]

  validates :name, :status, presence: true
  before_destroy :check_status

  def check_status
    if ['occupied', 'waiting'].include? status
      errors.add(:table_status, "is \"#{status}\". Table \"#{name}\" can not be deleted.")
      return false
    end
  end
end
