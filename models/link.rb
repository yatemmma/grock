module GROCK
  class Link < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end
end
