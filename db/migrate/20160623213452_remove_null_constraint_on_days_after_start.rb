class RemoveNullConstraintOnDaysAfterStart < ActiveRecord::Migration[4.2]
  def change
    change_column_null(:scheduled_messages, :days_after_start, true)
  end
end
