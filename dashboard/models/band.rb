module Grock
  class Band < ActiveRecord::Base
    extend Grock::ClassModel
    include Grock::InstanceModel
    
    def self.identifier
      :band
    end
  end
end
