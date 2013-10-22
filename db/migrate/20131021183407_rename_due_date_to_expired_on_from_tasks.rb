class RenameDueDateToExpiredOnFromTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :due_date, :expired_on
  end
end
