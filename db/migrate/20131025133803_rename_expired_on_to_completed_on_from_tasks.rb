class RenameExpiredOnToCompletedOnFromTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :expired_on, :completed_on
  end
end
