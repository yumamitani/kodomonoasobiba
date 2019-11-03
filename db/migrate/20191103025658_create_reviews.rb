class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :nickname
      t.string :prefecture
      t.text :subject
      t.text :text
      t.text :image
      t.text :movie
      t.integer :user_id
      t.timestamps
    end
  end
end
