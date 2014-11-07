namespace :cronjobs do
  desc "This task is called by the Heroku scheduler add-on"

  task :ranking => :winelevel do
    Crons::Ranking.update
  end

  task :winelevel => :environment do
    Crons::Winelevel.calculate
  end
end
