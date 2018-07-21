module GROCK
  class BandBand < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end
end
