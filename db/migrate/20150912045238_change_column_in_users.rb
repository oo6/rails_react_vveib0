class ChangeColumnInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :reset_digest, :password_reset_token
    rename_column :users, :reset_sent_at, :password_reset_email_send_at
    rename_column :users, :remember_digest, :remember_token
    rename_column :users, :activation_digest, :activation_token
  end
end
