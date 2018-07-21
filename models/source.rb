module GROCK
  class Source < ActiveRecord::Base
    self.inheritance_column = :_type_disabled

    validates :raw, :uniqueness => true, :allow_nil => true
  end
end
