class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :programmer
      t.string :project
      t.string :priority
      t.text :notes
      t.decimal :budget
      t.date :start_date
      t.date :due_date
      t.integer :progress
      t.string :status

      t.timestamps
    end
  end
end
