class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.references :user, foreign_key: true
      t.integer :other_user_id

      t.timestamps
    end
  end
end
