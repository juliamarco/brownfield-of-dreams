class AddTemporaryTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :temporary_token, :string
  end
end
