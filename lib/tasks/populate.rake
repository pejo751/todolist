namespace :db do

  desc "TODO"
  task populate: :environment do
    require 'populator'

    puts "** Hello! Will populate your DB now, please hold."
    populator = Populator.new

    puts "** => Populating site"
    populator.populate_site!
    puts "** => Done!"
  end

end
