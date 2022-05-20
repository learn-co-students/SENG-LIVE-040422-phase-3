class AddLastFeedingTime < ActiveRecord::Migration[6.1]
  def change
    add_column :dogs, :last_fed_at, :datetime
  end
end
