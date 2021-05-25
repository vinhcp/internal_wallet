class Transaction < ApplicationRecord
  include TransactionTypeManagement

  TX_ID_LENGTH = 32
  MIN_AMOUNT = 1
  NEGATIVE_RATE = -1
  STATUSES = { request: 0, processing: 1, success: 2, failed: 3 }.freeze

  attr_accessor :target_wallet_address

  belongs_to :source_wallet, class_name: 'Wallet', foreign_key: :source_wallet_id, optional: true
  belongs_to :target_wallet, class_name: 'Wallet', foreign_key: :target_wallet_id, optional: true
  belongs_to :user

  validates_presence_of :amount, :tx_id
  validates_uniqueness_of :tx_id
  validates_numericality_of :amount, greater_than_or_equal_to: MIN_AMOUNT

  enum status: STATUSES

  after_initialize do
    self.status = 0 if self.status.blank?
  end

  before_validation :generate_tx_id
  before_validation :assign_wallet

  def self.for_wallet(wallet)
    where('source_wallet_id = :wallet_id or target_wallet_id = :wallet_id',
          wallet_id: wallet.id)
  end

  def negative_amount
    amount * NEGATIVE_RATE
  end

  def positive_amount
    amount
  end

  def actual_amount(wallet = nil)
    wallet == source_wallet ? negative_amount : positive_amount
  end

  private

  def generate_tx_id
    return if tx_id.present?

    self.tx_id = loop do
      random_token = SecureRandom.urlsafe_base64(TX_ID_LENGTH, false)
      break random_token unless self.class.exists?(tx_id: random_token)
    end
  end
end
