class RenameMetricsToUserMetrics < ActiveRecord::Migration
  def change
    rename_table :metrics, :user_metrics
  end
end
