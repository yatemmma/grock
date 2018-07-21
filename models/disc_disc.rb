module GROCK
  class DiscDisc < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end
end
