class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :tx_id, index: true
      t.integer :transaction_type
      t.decimal :amount, precision: 10, scale: 2
      t.integer :creditor_id, index: true
      t.string :creditor_wallet_address
      t.integer :debtor_id, index: true
      t.string :debtor_wallet_address
      t.integer :status

      t.timestamps
    end
  end
end
