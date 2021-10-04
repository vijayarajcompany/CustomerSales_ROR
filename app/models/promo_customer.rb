class PromoCustomer < ApplicationRecord
  belongs_to :promotion
  belongs_to :customer, class_name: 'User'
end
