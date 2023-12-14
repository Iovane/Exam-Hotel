class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :title
      t.string :address
      t.integer :user_id

      t.timestamps
    end
  end
end
