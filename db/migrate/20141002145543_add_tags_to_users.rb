class AddTagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hashtags, :string, array: true, default: []
  end
end
