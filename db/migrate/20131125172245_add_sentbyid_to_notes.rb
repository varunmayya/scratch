class AddSentbyidToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :sent_by_id, :integer
  end
end
