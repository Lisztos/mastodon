class RemoveKeyFieldsFromAccount < ActiveRecord::Migration[6.1]
  def change
    safety_assured { remove_column :accounts, :public_key }
    safety_assured { remove_column :accounts, :private_key }
  end
end
