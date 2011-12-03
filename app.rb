require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'mongoid'
require 'lib/checkin'

class App < Sinatra::Base

    set :root, File.dirname(__FILE__)

    configure do
      Mongoid.configure do |config|
        name = "stamkroeg_development"
        host = "localhost"
        config.master = Mongo::Connection.new.db(name)
        config.slaves = [
          Mongo::Connection.new(host, 27017, :slave_ok => true, :autocreate_indexes => true).db(name)
        ]
        config.persist_in_safe_mode = false
      end

      set :environment, :develop
      set :dump_errors, true
      set :haml, { :ugly=>true }
      set :clean_trace, true
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
    get '/' do
      "Thanks for visiting Stamkroeg. Now please download the Android or iPhone app to use it!"
    end
    
end
