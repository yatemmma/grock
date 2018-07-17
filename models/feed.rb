module GROCK
  class Feed < ActiveRecord::Base
    self.primary_key = :code
  end
end
