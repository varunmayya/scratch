class ChangeString < ActiveRecord::Migration
  def change
    change_column :notes, :data, :text
  end
end
