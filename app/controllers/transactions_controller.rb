class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_transaction, only: %i[new create]

  def index
    @transactions = Transaction.for_wallet(current_wallet)
                               .includes(:source_wallet, :target_wallet)
  end

  def new; end

  def create
    if @transaction.save
      TransactionService.new(@transaction).perform
      flash[:success] = 'You have added new transaction'
      redirect_to transactions_path
    else
      flash.now[:error] = @transaction.errors.full_messages.first
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :target_wallet_address)
  end

  def assign_transaction
    attrs = params[:transaction] ? transaction_params.merge(user: current_user) : {}
    @transaction = Transaction.class_for_type(params[:type]).new(attrs)
  end
end
