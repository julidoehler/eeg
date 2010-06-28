class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.date :date_from
      t.time :time_from, :default => nil
      t.date :date_to
      t.time :time_to, :default => nil
      t.string :title
      t.text :short_text
      t.text :long_text
      t.boolean :published
      t.integer :to_twitter_count, :null => false, :default => 0
      t.integer :to_facebook_count, :null => false, :default => 0
      t.integer :to_myspace_count, :null => false, :default => 0
      t.references :picture

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
