class AddSearchidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :search_id, :string
  end
end
