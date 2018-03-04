require "./musiki/metadata"

def read_files(dir)
  data = {}
  Dir.glob("src/#{dir}/*").each do |path|
    text = File.open(path).read
    banddata = Metadata.new(text)
    data[banddata[:code]] = banddata
  end
  data
end

@labels = read_files("label")
@members = read_files("member")
@songs = read_files("song")
@bands = read_files("band")
@discs = read_files("disc")

puts @labels
puts @members
puts @songs
puts @bands
puts @discs
