module GROCK
  class DiscLabel < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end
end
