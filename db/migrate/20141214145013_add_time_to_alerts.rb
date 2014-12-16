class AddTimeToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :time, :datetime
  end
end
