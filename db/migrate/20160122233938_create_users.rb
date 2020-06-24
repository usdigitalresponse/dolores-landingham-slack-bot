class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :email, null: false
      t.boolean :admin, default: false
    end
  end
end
