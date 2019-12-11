class CreateRmsClients < ActiveRecord::Migration[6.0]
  def change
    create_table :rms_clients do |t|
      t.string :name, null: false
      t.string :tel
      t.string :email
      t.string :address1
      t.string :address2
      t.string :address3
      t.text :info

      t.timestamps
    end
    
    add_index :rms_clients, :name, :unique  => true    
  end
end
