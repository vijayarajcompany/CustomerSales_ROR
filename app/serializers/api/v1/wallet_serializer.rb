class Api::V1::WalletSerializer < ActiveModel::Serializer
  attributes :id, :current_credit_limit, :outstanding_credit_limit, :pending_credit_limit
end