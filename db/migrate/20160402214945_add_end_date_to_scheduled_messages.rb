class AddEndDateToScheduledMessages < ActiveRecord::Migration[4.2]
  def change
    add_column :scheduled_messages, :end_date, :date
  end
end
