module Grock
  class Label < ActiveRecord::Base
    extend Grock::ClassModel
    include Grock::InstanceModel
    
    def self.identifier
      :label
    end
  end
end
