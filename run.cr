require "zlib"

spawn do
  i = 0
  loop do
    puts "[#{i}] looping"
    i += 1
    sleep 1
  end
end

# Wait 3 sec to start
sleep 3

File.open("data.bin", "r") do |file|
  Zlib::Reader.new(file).gets_to_end
end
