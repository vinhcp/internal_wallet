class Transaction < ApplicationRecord
  TX_ID_LENGTH = 32

  belongs_to :creditor, class_name: 'User', foreign_key: :creditor_id
  belongs_to :debtor, class_name: 'User', foreign_key: :debtor_id

  validates_presence_of :creditor_id, :debtor_id, :creditor_wallet_address,
                        :debtor_wallet_address, :amount, :tx_id
  validates_uniqueness_of :tx_id

  enum status: { request: 0, processing: 1, success: 2, failed: 3 }
  enum transaction_type: { deposit: 0, withdraw: 1, transfer: 0 }

  after_initialize do
    self.status = 0 if self.status.blank?
  end

  before_validation :generate_address

  private

  def generate_address
    self.tx_id = loop do
      random_token = SecureRandom.urlsafe_base64(TX_ID_LENGTH, false)
      break random_token unless self.class.exists?(tx_id: random_token)
    end
  end
end
