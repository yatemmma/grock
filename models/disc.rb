module GROCK
  class Disc < ActiveRecord::Base
    self.primary_key = :code
    self.inheritance_column = :_type_disabled
  end
end
