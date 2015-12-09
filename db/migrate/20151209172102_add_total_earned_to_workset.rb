class AddTotalEarnedToWorkset < ActiveRecord::Migration
  def change
    add_column :workset, :total_earned, :float
  end
end
