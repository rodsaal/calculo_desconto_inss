class CreateProponents < ActiveRecord::Migration[7.1]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :document
      t.date :birthdate
      t.decimal :salary
      t.decimal :inss_discount

      t.timestamps
    end
  end
end
