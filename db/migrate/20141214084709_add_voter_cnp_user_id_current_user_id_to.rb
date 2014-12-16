class AddVoterCnpUserIdCurrentUserIdTo < ActiveRecord::Migration
  def change
  	add_column :alerts, :voter_cnp, :integer
  	add_column :alerts, :user_id, :integer
  	add_column :alerts, :current_user_id, :integer
  end
end
