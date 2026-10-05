class CreatePageImages < ActiveRecord::Migration[8.1]
  def change
    create_table :page_images do |t|
      t.string :page, null: false
      t.string :section, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :page_images, [ :page, :section ]
  end
end
