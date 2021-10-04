class Banner < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  # def avatar_url
  #   avatar.url(:thumb)
  # end
end
