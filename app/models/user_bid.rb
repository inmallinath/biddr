class UserBid < ActiveRecord::Base
  belongs_to :user#, dependent: :destroy
  belongs_to :auction

  validates :bid_price, presence: true, numericality: {greater_than: 0}

  
end
