module Grock
  class Post < ActiveRecord::Base
    extend Grock::ClassModel
    include Grock::InstanceModel
    
    def self.identifier
      :post
    end
  end
end
