class AddTypeToScheduledMessages < ActiveRecord::Migration[4.2]
  def change
    add_column :scheduled_messages, :message_time_frame, :integer, default: 0
  end
end
