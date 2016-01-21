module Grock
  class Video < ActiveRecord::Base
    extend Grock::ClassModel
    include Grock::InstanceModel
    
    def self.identifier
      :video
    end
  end
end
