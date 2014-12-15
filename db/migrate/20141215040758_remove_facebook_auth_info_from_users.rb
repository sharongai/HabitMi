class RemoveFacebookAuthInfoFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :uid
      t.remove :provider
      t.remove :oauth_token
      t.remove :oauth_expires_at
    end
  end
end
