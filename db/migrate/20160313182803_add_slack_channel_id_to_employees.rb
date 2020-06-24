class AddSlackChannelIdToEmployees < ActiveRecord::Migration[4.2]
  def change
    add_column :employees, :slack_channel_id, :string
  end
end
