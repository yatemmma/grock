module GROCK
  class Link < ActiveRecord::Base
    self.primary_key = :code
  end
end
