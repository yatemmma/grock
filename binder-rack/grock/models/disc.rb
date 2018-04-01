require_relative "../submodels/models"
require_relative "../../core/models/metadata"

module GROCK
  class Disc < BinderRack::Core::Metadata
    prop :code
    prop :name, GName
    prop :band
  end
end
