class CreateVoters < ActiveRecord::Migration
  def change
    create_table :voters, id: false do |t|
      t.primary_key :cnp
      t.string :last_name
      t.string :first_name
      t.string :address
      t.string :zone
      t.references :user, index: true

      t.timestamps
    end
  end
end
