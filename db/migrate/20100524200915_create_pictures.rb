class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.text :description
      t.references :gallery
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
