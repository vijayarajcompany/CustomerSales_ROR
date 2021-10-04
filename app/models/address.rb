class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  geocoded_by :full_address
  after_validation :geocode, if: -> (obj) {
  	(obj.address.present? and obj.address_changed?) ||
  	(obj.title.present? and obj.title_changed?) }
  enum address_type: [ "business_customer", "home_delivery" ]

  def full_address
  	"#{title} #{address}"
  end
end
