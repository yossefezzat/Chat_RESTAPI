class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number
      t.integer :message_count, default: 0
      t.references :application, null: false, foreign_key: true

      t.timestamps
    end
  end
end