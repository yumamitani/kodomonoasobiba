class User < ApplicationRecord
validates :nickname , {presence: true , uniqueness: true}
validates :password , {presence: true}

has_many :reviews
mount_uploader :image_name, ImageUploader
end
