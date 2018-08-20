require "zlib"

class NoPeekIO < IO::Memory
  def peek
    nil
  end
end

File.open("data.bin", "r") do |file|
  io = NoPeekIO.new
  IO.copy(file, io)
  io.rewind
  Zlib::Reader.new(io).gets_to_end
end
