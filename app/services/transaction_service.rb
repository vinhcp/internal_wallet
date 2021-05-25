class TransactionService
  attr_accessor :transaction

  def initialize(transaction)
    @transaction = transaction
  end

  def perform
    transaction.processing!
    ActiveRecord::Base.transaction do
      transaction.perform
      transaction.success!
    end
  rescue ActiveRecord::RecordInvalid => exception
    transaction.reason = { message: exception.message, details: exception.backtrace }
    transaction.save
    transaction.failed!
  end
end
