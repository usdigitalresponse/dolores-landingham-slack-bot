class AddSentAtToSentScheduledMessages < ActiveRecord::Migration[4.2]
  def change
    add_column :sent_scheduled_messages, :sent_at, :time, null: false, default: "12:00:00"
  end
end
