class RenameStartDateToStartedOnFromTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :start_date, :started_on
  end
end
