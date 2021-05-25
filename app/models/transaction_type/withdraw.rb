module TransactionType
  class Withdraw < Transaction
    validates_presence_of :source_wallet_id

    def perform
      source_wallet.transfer!(negative_amount)
    end

    private

    def assign_wallet
      self.source_wallet = user.wallet if source_wallet.blank?
    end
  end
end
