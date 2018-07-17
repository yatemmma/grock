module GROCK
  class Band < ActiveRecord::Base
    self.primary_key = :code
  end
end
