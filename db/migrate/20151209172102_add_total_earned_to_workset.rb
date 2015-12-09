class AddTotalEarnedToWorkset < ActiveRecord::Migration
  def change
    add_column :workset, :total_earned, :real
  end
end
