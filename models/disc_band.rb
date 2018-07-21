module GROCK
  class DiscBand < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end
end
