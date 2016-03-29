class User < ActiveRecord::Base
  has_secure_password
  has_many :auctions

  validates :first_name, :last_name, presence: true
  validates :password, length: {minimum: 6}, on: :create
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i unless :from_oauth?
  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
