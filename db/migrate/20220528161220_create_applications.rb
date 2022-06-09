class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :app_key
      t.integer :chat_count, default: 0
      t.timestamps
    end
    add_index :applications, :app_key, unique: true
  end
end