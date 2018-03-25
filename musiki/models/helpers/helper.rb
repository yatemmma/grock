require "./musiki/models/helpers/sns_helper"
require "./musiki/models/helpers/country_helper"
require "./musiki/models/helpers/genre_helper"
require "./musiki/models/helpers/active_helper"
require "./musiki/models/helpers/video_helper"
require "./musiki/models/helpers/date_helper"
require "./musiki/models/helpers/image_helper"
require "./musiki/models/helpers/disc_helper"

DOMAIN = "https://scream.your.name/"

module AttributeHelper
  include ActiveHelper
  include CountryHelper
  include DateHelper
  include GenreHelper
  include ImageHelper
  include SNSHelper
  include VideoHelper
  include DiscHelper
end
