require "zlib"

File.open("data.bin", "r") do |io|
  Zlib::Reader.new(io).gets_to_end
end
