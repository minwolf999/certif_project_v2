class AddProviderToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :otp_sent_at, :datetime
  end
end
