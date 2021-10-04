class Promoitem < ApplicationRecord
  belongs_to :promotion
  belongs_to :customer, class_name: 'User', optional: true
end
