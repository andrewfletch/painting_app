class Post < ApplicationRecord
    belongs_to :category
    mount_uploader :image, ImageUploader
    validates :title, :content, :category_id, presence: true
end
