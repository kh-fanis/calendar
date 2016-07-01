class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender,  index: true, foreign_key: true
      t.references :reciver, index: true, foreign_key: true
      t.string     :content
      t.boolean    :deleted_by_sender
      t.boolean    :deleted_by_reciver

      t.timestamps null: false
    end
  end
end
