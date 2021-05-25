module TransactionType
  class Deposit < Transaction
    validates_presence_of :target_wallet_id

    def perform
      target_wallet.recalculate_amount!
    end

    private

    def assign_wallet
      self.target_wallet = user.wallet if target_wallet.blank?
    end
  end
end
