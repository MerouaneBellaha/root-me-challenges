require 'base64'
require 'zlib'
require_relative 'tcp_socket_handler'

socket_handler = Socket_handler.new('challenge01.root-me.org', 52022)

def target_message_decode_decompress(message)
  code = message.match(/'(.*?)'/)[1]
  decoded = Base64.decode64(code)
  return Zlib::Inflate.inflate(decoded)
end

socket_handler.open_socket

while (message = read_message) && !message.include?('Good job')
  decompressed = target_message_decode_decompress(message)
  socket_handler.send_value(decompressed)
end 

socket_handler.close_socket