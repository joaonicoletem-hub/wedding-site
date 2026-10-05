class CreatePageSections < ActiveRecord::Migration[8.1]
  def change
    create_table :page_sections do |t|
      t.string :page, null: false
      t.string :name, null: false
      t.string :title
      t.text :body

      t.timestamps
    end

    add_index :page_sections, [ :page, :name ], unique: true
  end
end
