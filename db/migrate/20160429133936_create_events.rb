class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string     :name,        null: false, default: ''
      t.date       :date,        null: false
      t.string     :description, null: false, default: ''
      t.references :user

      t.timestamps null: false
    end
  end
end
