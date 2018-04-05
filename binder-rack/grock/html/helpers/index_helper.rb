module GROCK
  module IndexHelper
    def featured(data_list)
      type = [Disc, Song].sample
      key = data_list[type].keys.sample
      obj = data_list[type][key]
      posted = "posted at 2018/04/05"
      [obj, posted]
    end
  end
end
