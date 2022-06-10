class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number
      t.text :body
      t.string :app_key  # added to filter search in chats by app_key and chat number in this app_key  
      t.references :chat, null: false, foreign_key: true
      t.timestamps
    end
  end
end