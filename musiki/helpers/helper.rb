require "./musiki/helpers/sns_helper"
require "./musiki/helpers/country_helper"
require "./musiki/helpers/genre_helper"
require "./musiki/helpers/active_helper"
require "./musiki/helpers/video_helper"
require "./musiki/helpers/date_helper"
require "./musiki/helpers/image_helper"

DOMAIN = "https://scream.your.name/"

module Helper
  include ActiveHelper
  include CountryHelper
  include DateHelper
  include GenreHelper
  include ImageHelper
  include SNSHelper
  include VideoHelper
end
