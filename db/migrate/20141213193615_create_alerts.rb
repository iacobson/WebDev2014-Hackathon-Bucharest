class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.text :description

      t.timestamps
    end
  end
end
