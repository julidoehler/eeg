class CreateBackgrounds < ActiveRecord::Migration
  def self.up
    create_table :backgrounds do |t|
      t.int :parent_id
      t.int :picture_id

      t.timestamps
    end
  end

  def self.down
    drop_table :backgrounds
  end
end
