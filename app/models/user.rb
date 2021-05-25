class User < ApplicationRecord
  USER_TYPES = %w[Team Stock].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  has_one :wallet
  has_many :transactions

  validates :type, inclusion: { in: USER_TYPES }

  after_create :create_wallet
end
