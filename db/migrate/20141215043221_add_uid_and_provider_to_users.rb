class AddUidAndProviderToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :uid
      t.string :provider
    end
  end
end
