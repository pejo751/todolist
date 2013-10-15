require 'faker'

module Populator
  def populate_projects!
    Project.destroy_all
    [2, 3].sample.times do
      p = Project.create(
        name: Faker::Company::name,
        description: Faker::Lorem.paragraphs.join("\n")
      )
      p.save!
    end
  end

  def populate_tasks!
    Task.destroy_all
    populate_projects! if Project.count(:id) == 0
    Project.all.each do |project|
      [7, 8, 9].sample.times do
        t            = project.tasks.build
        t.name       = Faker::Company::name
        t.programmer = Faker::Name::name
        t.priority   = Task::PRIORITY_DOMAIN.sample
        t.notes      = Faker::Lorem.paragraphs.join("\n")
        t.budget     = [100,200,300].sample
        t.start_date = nil
        t.due_date   = nil
        t.status     = Task::STATUS_DOMAIN.sample
        t.kind       = Task::KIND_DOMAIN.sample
        t.save!
      end
    end
  end
end
