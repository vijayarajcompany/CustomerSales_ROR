class Wallet < ApplicationRecord
  belongs_to :user
  before_save :adjust_amount!


  def adjust_amount!
    self.pending_credit_limit = self.current_credit_limit - self.outstanding_credit_limit
  end

  def deduct_amount!(amount)
    update(outstanding_credit_limit: self.outstanding_credit_limit + amount)
  end

  def pay_outstanding_balance!(amount)
    update(outstanding_credit_limit: self.outstanding_credit_limit - amount)
  end
end
