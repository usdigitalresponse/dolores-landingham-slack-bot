class CreateEmployees < ActiveRecord::Migration[4.2]
  def change
    create_table :employees do |t|
      t.timestamps null: false
      t.string :slack_username, null: false
      t.date :started_on, null: false
    end
  end
end
