class CreateBackgrounds < ActiveRecord::Migration
  def self.up
    create_table :backgrounds do |t|
      t.integer :parent_id
      t.string :parent_type
      t.string :data_file_name
      t.string :data_content_type
      t.integer :data_file_size
      t.datetime :data_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :backgrounds
  end
end
