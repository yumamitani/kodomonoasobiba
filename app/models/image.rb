class Image < ApplicationRecord
  belongs_to :review
  mount_uploader :image_url, ImageUploader
end
