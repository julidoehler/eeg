class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.date :date_from
      t.time :time_from, :default => :null
      t.date :date_to
      t.time :time_to, :default => :null
      t.string :title
      t.text :short_text
      t.boolean :published
      t.boolean :post_to_twitter
      t.boolean :post_to_facebook
      t.boolean :post_to_myspace

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
