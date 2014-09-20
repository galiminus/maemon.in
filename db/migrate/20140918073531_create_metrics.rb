class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.string          :name
      t.integer         :value
      t.timestamps
    end
  end
end
