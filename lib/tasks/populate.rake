namespace :db do

  desc "TODO"
  task populate: :environment do
    require 'populator'  #lib/populator.rb
    include Populator    # modulo en populator.rb

    puts "** Hello! Will populate your DB now, please hold."

    puts "** => Populating Projects"
    populate_projects!
    puts "** => Done!"

    puts "** => Populating Tasks"
    populate_tasks!
    puts "** => Done!"
  end

end
