require_relative "../submodels/models"
require_relative "../../core/models/metadata"

module GROCK
  class Member < BinderRack::Core::Metadata
    prop :code
    prop :name, GName
  end
end
