class CreateVoteLogs < ActiveRecord::Migration
  def change
    create_table :vote_logs do |t|
      t.references :user, index: true
      t.references :voucher, index: true
      t.references :participation, index: true
      t.boolean :vouched, default: false

      t.timestamps
    end
  end
end
