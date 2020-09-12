class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :other_user_id

      t.timestamps
    end
  end
end
