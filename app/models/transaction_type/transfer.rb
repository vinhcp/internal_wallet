module TransactionType
  class Transfer < Transaction
    validates_presence_of :source_wallet_id
    validates_presence_of :target_wallet_id
    validate :source_wallet_cannot_be_target_wallet

    def perform
      source_wallet.recalculate_amount!
      target_wallet.recalculate_amount!
    end

    private

    def assign_wallet
      self.source_wallet = user.wallet if source_wallet.blank?
      self.target_wallet = Wallet.find_by(address: target_wallet_address) if target_wallet.blank?
    end

    def source_wallet_cannot_be_target_wallet
      errors.add(:source_and_target_wallet, 'can\'t be same') if source_wallet == target_wallet
    end
  end
end
