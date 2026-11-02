class CreateRsvps < ActiveRecord::Migration[8.1]
  def change
    create_table :rsvps do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.boolean :attending, null: false, default: true
      t.integer :guests_count, null: false, default: 1
      t.text :message

      t.timestamps
    end

    add_index :rsvps, :email
  end
end
