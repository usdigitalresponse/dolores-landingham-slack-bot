class AddSlackUserIdToEmployee < ActiveRecord::Migration[4.2]
  def change
    add_column :employees, :slack_user_id, :string
    add_index :employees, :slack_user_id
  end
end
