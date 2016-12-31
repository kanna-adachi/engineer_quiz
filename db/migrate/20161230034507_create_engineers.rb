class CreateEngineers < ActiveRecord::Migration
  def change
    create_table :engineers do |t|
      t.string :last_name
      t.string :nickname
      t.text :image
      t.binary :file

      t.timestamps null: false
    end
  end
end
