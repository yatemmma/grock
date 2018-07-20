module GROCK
  class Tag < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end
end
