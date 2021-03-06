class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :question, index: true, foreign_key: true

      t.timestamps
    end
  end
end
