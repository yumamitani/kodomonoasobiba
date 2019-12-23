class Review < ApplicationRecord
  validates:prefecture,{presence:true}
  validates:subject,{presence:true}
  validates:text,{presence:true , length:{maximum:200}}
  validates:user_id, {presence: true}

  belongs_to :user
  belongs_to :prefecture
  has_many :likes
  has_many :images,dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy:true
end
