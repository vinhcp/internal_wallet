class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :tx_id
      t.string :type
      t.decimal :amount, precision: 10, scale: 2
      t.integer :source_wallet_id, index: true
      t.integer :target_wallet_id, index: true
      t.integer :status
      t.jsonb :reason
      t.references :user

      t.timestamps
    end
  end
end
