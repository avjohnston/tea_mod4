class CreateTeas < ActiveRecord::Migration[5.2]
  def change
    create_table :tea_types do |t|
      t.string :title
      t.text :description
      t.integer :temperature
      t.integer :brew_time

      t.timestamps
    end
  end
end
