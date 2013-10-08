class RemoveProjectToTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :project, :string
  end
end
