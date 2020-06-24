class AddTimeOfDayToScheduledMessages < ActiveRecord::Migration[4.2]
  def change
    add_column :scheduled_messages, :time_of_day, :time, null: false, default: "12:00:00"
  end
end
