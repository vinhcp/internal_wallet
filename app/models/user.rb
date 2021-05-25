class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  has_one :wallet
  has_many :credit_transactions, class_name: 'Transaction', foreign_key: :creditor_id
  has_many :debit_transactions, class_name: 'Transaction', foreign_key: :debtor_id

  after_create :create_wallet
end
