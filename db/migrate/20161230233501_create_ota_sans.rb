class CreateOtaSans < ActiveRecord::Migration
  def change
    create_table :ota_sans do |t|
      t.string :first_name
      t.string :image

      t.timestamps null: false
    end
  end
end
