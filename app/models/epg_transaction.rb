class EpgTransaction < ApplicationRecord
  CURRENCY = "AED"
  TRANSACTIONHINT = "CPT:Y;VCC:Y;"

  belongs_to :user
  belongs_to :order
end
