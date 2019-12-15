class AddColumnReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :prefecture_id, :integer
    remove_column :reviews, :prefecture
      

  end
end
