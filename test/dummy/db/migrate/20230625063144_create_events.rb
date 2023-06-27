class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :published
      t.integer :price
      t.integer :status

      t.timestamps
    end
  end
end
