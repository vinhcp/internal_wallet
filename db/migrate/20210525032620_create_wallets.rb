class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.string :address, index: true
      t.decimal :amount, precision: 10, scale: 2, default: 0
      t.references :user

      t.timestamps
    end
  end
end
