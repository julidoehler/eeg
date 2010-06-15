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
      t.boolean :post_to_twitter
      t.boolean :post_to_facebook
      t.boolean :post_to_myspace
      t.references :picture

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
