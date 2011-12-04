require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'mongoid'
require 'uri'
require 'lib/checkin'

class App < Sinatra::Base

    set :root, File.dirname(__FILE__)
    
    #url = URI.parse ENV["MONGODB_URL"]
    #MONGO = Mongo::Connection.new(url.host, url.port).db url.path[1..-1]
    #if url.user && url.password
    #  unless MONGO.authenticate url.user, url.password
    #    raise "Couldn't authenticate MongoDB: #{url.to_s}"
    #  end
    #end


    #TODO: change this to a "configure :production do" block and a "configure :development do" block
    configure do
      Mongoid.configure do |config|
        name = "sk_db"
        host = "localhost"
        config.master = Mongo::Connection.new.db(name)
        #config.slaves = [
        #  Mongo::Connection.new(host, 27017, :slave_ok => true, :autocreate_indexes => true).db(name)
        #]
        
        
        #config.autocreate_indexes = true
        
        
        #config.master = MONGO
        #config.raise_not_found_error = false
        
        config.persist_in_safe_mode = false
        
      end

      set :environment, :develop
      set :dump_errors, true
      set :haml, { :ugly=>true }
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
