class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.references :proponent, null: false, foreign_key: true
      t.string :contact_type
      t.string :value

      t.timestamps
    end
  end
end
