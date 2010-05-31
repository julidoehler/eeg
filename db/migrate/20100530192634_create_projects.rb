class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.date :date_from
      t.date :date_to
      t.string :title
      t.text :info

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
