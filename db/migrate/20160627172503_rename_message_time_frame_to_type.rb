class RenameMessageTimeFrameToType < ActiveRecord::Migration[4.2]
  def change
    rename_column :scheduled_messages, :message_time_frame, :type
  end
end
