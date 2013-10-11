class RemoveProgressFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :progress, :string
  end
end
