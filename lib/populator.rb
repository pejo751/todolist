require 'faker'

class Populator

  def initialize
  end

  def populate_site!

    puts "** => Populating Projects"
    projects!

    puts "** => Populating Tasks"
    tasks!
  end

  protected

  def projects!
    Project.destroy_all
    [2, 3].sample.times do
      p = Project.create(
        name: Faker::Company::name,
        description: Faker::Lorem.paragraphs.join("\n")
      )
      p.save!
    end
  end

  def tasks!
    Task.destroy_all
    projects! if Project.count(:id) == 0
    Project.all.each do |project|
      [7, 8, 9].sample.times do
        t            = project.tasks.build
        t.name       = Faker::Company::name
        t.programmer = Faker::Name::name
        t.priority   = Task::PRIORITIES.sample
        t.notes      = Faker::Lorem.paragraphs.join("\n")
        t.budget     = [100,200,300].sample
        t.started_on = nil
        t.expired_on = nil
        t.status     = Task::STATUSES.sample
        t.kind       = Task::KINDS.sample
        t.save!
      end
    end
  end
end
