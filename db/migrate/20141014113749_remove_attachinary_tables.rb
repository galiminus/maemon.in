class RemoveAttachinaryTables < ActiveRecord::Migration
  def change
    drop_table :attachinary_files
  end
end
