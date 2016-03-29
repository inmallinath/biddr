class Auction < ActiveRecord::Base
  belongs_to :user

  include AASM

  validates :title, presence: true, uniqueness: true
  validates :reserve_price, presence: true, numericality: {greater_than: 0}
  validates :ends_on, presence: true
  validate :ends_on_date_cannot_be_in_the_past

  def ends_on_date_cannot_be_in_the_past
    if ends_on.present? && ends_on < Date.today
      errors.add(:ends_on, "Ending Date cannot be in the past")
    end
  end
  aasm whiny_transitions: false do
    state :draft, :initial => true
    state :published
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met

    event :publish do
      transitions from: :draft, to: :published
    end

    event :cancel do
      transitions from: [:draft, :published, :reserve_met, :reserve_not_met], to: :canceled
    end

    event :reserve_met do
      transitions from: [:published, :reserve_not_met], to: :reserve_met
    end

    event :won do
      transitions from: [:published, :reserve_met], to: :won
    end

    event :reserve_not_met do
      transitions from: :published, to: :reserve_not_met
    end

  end
end
