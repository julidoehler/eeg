class CreateElements < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.string :title
      t.string :content_type
      t.text :content
      t.integer :parent_id
      t.string :parent_type
      t.timestamps
    end
  end

  def self.down
    drop_table :elements
  end
end
