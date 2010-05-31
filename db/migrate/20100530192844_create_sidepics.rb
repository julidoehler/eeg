class CreateSidepics < ActiveRecord::Migration
  def self.up
    create_table :sidepics do |t|
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :sidepics
  end
end
