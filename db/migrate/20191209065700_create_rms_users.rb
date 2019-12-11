class CreateRmsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :rms_users do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.boolean :admin, null: false

      t.timestamps
    end
  end
end
