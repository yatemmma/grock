module GROCK
  class RawFeed < ActiveRecord::Base
    validates :source, uniqueness: true, allow_nil: true
  end
end
