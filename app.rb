require 'bundler'
Bundler.require(:default)

require 'uri'
require './lib/checkin'

class App < Sinatra::Base

    set :root, File.dirname(__FILE__)
    
    configure do
      Mongoid.configure do |config|
        name = "sk_db"
        host = "localhost"
        config.master = Mongo::Connection.new.db(name)
        config.persist_in_safe_mode = false        
      end

      set :dump_errors, true
      set :haml, { :ugly => true }
      set :clean_trace, true
    end
    
    configure :production do
      Mongoid.configure do |config|
        config.master = Mongo::Connection.new.db(MONGOHQ_URL)
        config.persist_in_safe_mode = false        
      end

      set :dump_errors, true
      set :haml, { :ugly => true }
      set :clean_trace, true
    end
    
    get '/' do
      "Thanks for visiting Stamkroeg. Now please download the Android or iPhone app to use it!"
    end

    get '/checkins.json' do
      {'people' => Checkin.within(:lat => params[:lat].to_f, :lng => params[:lng].to_f).recently}.to_json
    end

    get '/checkin' do
      checkin = Checkin.find_or_initialize_by(:mobile_number => params[:mobile_number])
      checkin.update_attributes!(
        :coordinates => [ params[:lat].to_f, params[:lng].to_f],
        :name => params[:name]
      )
    end
end
