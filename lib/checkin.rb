require 'mongoid'

class Checkin
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :mobile_number
  field :coordinates, :type => Array, :default => []

  index [[ 'coordinates', Mongo::GEO2D ]], :min => -180, :max => 180 # create 2d index
  

  scope :within, lambda { |options|
    # divide by 111 because stackoverflow says so
    # (http://stackoverflow.com/questions/7848634/maximum-distance-with-mongoids-model-near-method)
    distance = 0.05.fdiv(111)
    where({
      "coordinates" => {
        "$within" => {
          "$center" => [
            [options[:lat], options[:lng]],
            distance
          ]
        }
      }
    })
  }

  scope :recently, lambda {
    where(:updated_at.gte => 1.hour.ago)
  }

end
