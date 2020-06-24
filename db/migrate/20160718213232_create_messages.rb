class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.datetime :last_sent_at
      t.timestamps null: false
    end
  end
end
