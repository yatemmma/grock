module GROCK
  class Source < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end
end
