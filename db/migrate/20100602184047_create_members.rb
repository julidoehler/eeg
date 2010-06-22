class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :lastname
      t.string :firstname
      t.text :information
      t.references :picture

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
