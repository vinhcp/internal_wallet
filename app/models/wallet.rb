class Wallet < ApplicationRecord
  ADDRESS_LENGTH = 24
  belongs_to :user

  validates_presence_of :address
  validates_uniqueness_of :address

  before_validation :generate_address

  private

  def generate_address
    self.address = loop do
      random_token = SecureRandom.urlsafe_base64(ADDRESS_LENGTH, false)
      break random_token unless self.class.exists?(address: random_token)
    end
  end
end
