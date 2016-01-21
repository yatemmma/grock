module Grock
  class Disc < ActiveRecord::Base
    extend Grock::ClassModel
    include Grock::InstanceModel
    
    def self.identifier
      :disc
    end
  end
end
