require "./musiki/metadata"

@bands = {}

def read_band_files
  puts "[info] load bands data..."
  Dir.glob("src/band/*").each do |path|
    text = File.open(path).read
    banddata = Metadata.new(text)

    banddata[:band_code] = "hoge1"
    puts banddata[:band_code]
    puts banddata["band_code"]
    banddata["band_code"] = "hoge2"
    puts banddata[:band_code]
    puts banddata["band_code"]

    @bands[banddata.band_code] = banddata
  end
end

read_band_files

puts @bands
