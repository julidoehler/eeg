class CreateSidepics < ActiveRecord::Migration
  def self.up
    create_table :sidepics do |t|
      t.string :link
      t.references :picture
      t.timestamps
    end
  end

  def self.down
    drop_table :sidepics
  end
end
