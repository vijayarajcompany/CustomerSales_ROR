ActiveAdmin.register UserTradeOffer do

  permit_params do
    permitted = [:trade_offer_id, :user_id]
  end
  
end
