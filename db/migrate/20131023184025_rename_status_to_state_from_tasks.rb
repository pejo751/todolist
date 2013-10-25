class RenameStatusToStateFromTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :status, :state
  end
end
