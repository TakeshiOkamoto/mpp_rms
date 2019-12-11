class CreateRmsRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :rms_requests do |t|
      t.integer :client_id, null: false
      t.string  :title, null: false      
      t.integer :types, null: false
      t.integer :yyyy, null: false
      t.integer :mm, null: false
      t.integer :dd, null: false
      t.integer :day_times, null: false
      t.integer :sales, default: 0
      t.integer :expense1, default: 0
      t.integer :expense2, default: 0
      t.integer :expense3, default: 0
      t.integer :expense4, default: 0
      t.integer :expense5, default: 0
      t.integer :expense6, default: 0
      t.integer :expense7, default: 0
      t.integer :expense8, default: 0
      t.integer :expense9, default: 0
      t.integer :expense10, default: 0
      t.text :content
      t.text :remarks

      t.timestamps
    end
    
    add_index :rms_requests, :client_id, :unique  => false
    add_index :rms_requests, :title, :unique  => false    
    add_index :rms_requests, :types, :unique  => false
    add_index :rms_requests, :yyyy, :unique  => false
    add_index :rms_requests, :mm, :unique  => false  
    add_index :rms_requests, [:yyyy, :mm], unique: false        
  end
end
