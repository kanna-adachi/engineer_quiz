class AddColumnToEngineers < ActiveRecord::Migration
  def change
    add_column :engineers, :department, :string
    add_column :engineers, :fincchans, :string
    remove_column :engineers, :file, :binary
  end
end
