class Wallet < ApplicationRecord
  ADDRESS_LENGTH = 24
  MIN_AMOUNT = 0

  belongs_to :user
  has_many :positive_transactions, class_name: 'Transaction', foreign_key: :target_wallet_id
  has_many :negative_transactions, class_name: 'Transaction', foreign_key: :source_wallet_id

  validates :address, presence: true, uniqueness: true
  validates_numericality_of :amount, greater_than_or_equal_to: MIN_AMOUNT

  before_validation :generate_address

  def transfer!(amount)
    self.amount += amount
    save!
  end

  private

  def generate_address
    return if address.present?

    self.address = loop do
      random_token = SecureRandom.urlsafe_base64(ADDRESS_LENGTH, false)
      break random_token unless self.class.exists?(address: random_token)
    end
  end
end
