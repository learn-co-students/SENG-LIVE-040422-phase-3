class RemoveDogIdFromWalks < ActiveRecord::Migration[6.1]
  def change
    # remove_column(table_name, column_name, type, options)
    remove_column :walks, :dog_id, :integer
  end
end
