class CustomerMaster < ApplicationRecord
  validates_uniqueness_of :customercode
end
