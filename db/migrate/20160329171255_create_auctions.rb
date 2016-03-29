class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.string :description
      t.datetime :ends_on
      t.decimal :reserve_price
      t.string :aasm_state
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
