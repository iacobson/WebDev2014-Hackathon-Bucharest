class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :field, :string
    add_column :users, :voting_section, :string
  end
end
