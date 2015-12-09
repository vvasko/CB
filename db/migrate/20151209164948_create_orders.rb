class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :table_id
      t.integer :status
      t.real :sum
      t.timestamps null: false
    end
  end
end
