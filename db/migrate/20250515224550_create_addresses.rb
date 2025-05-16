class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :proponent, null: false, foreign_key: true
      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
