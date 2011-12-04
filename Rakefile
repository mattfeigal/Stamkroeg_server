

namespace :mongodb do
  desc "Start MongoDB"
  task :start do
    mkdir_p "sk_db"
    system "mongod --dbpath sk_db/"
    
    #Why is this command not working, or not running? Tries to run it After I close the app
    #system "rake db:mongoid:create_indexes"
    #rake db:mongoid:create_indexes
  end
end

namespace :rackup do
  desc "Start rackup for development"
  task :start do
    system "rackup app.rb"
  end
end


desc "Start everything"
multitask :start => ['mongodb:start', 'rackup:start']