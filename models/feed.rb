module GROCK
  class Feed < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end
end
