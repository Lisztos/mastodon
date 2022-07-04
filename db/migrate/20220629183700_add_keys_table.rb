class AddKeysTable < ActiveRecord::Migration[6.1]
  def change
    create_table(:keys) do |t|
      t.integer :purpose
      t.string :type
      t.text :public_key
      t.text :private_key
      t.json :jwk
      t.references :account, foreign_key: true, index: true
      t.timestamps
    end
  end
end
