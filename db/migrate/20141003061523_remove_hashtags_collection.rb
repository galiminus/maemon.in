class RemoveHashtagsCollection < ActiveRecord::Migration
  def change
    remove_column :users, :hashtags
  end
end
