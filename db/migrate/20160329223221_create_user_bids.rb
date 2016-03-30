class CreateUserBids < ActiveRecord::Migration
  def change
    create_table :user_bids do |t|
      t.decimal :bid_price
      t.datetime :bid_date
      t.references :user, index: true, foreign_key: true
      t.references :auction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
