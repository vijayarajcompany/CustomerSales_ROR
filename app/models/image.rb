class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  mount_uploader :avatar, AvatarUploader

  # def avatar_url
  #   avatar.url(:thumb)
  # end
end
