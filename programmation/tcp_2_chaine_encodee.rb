require 'base64'
require_relative 'tcp_socket_handler'

socket_handler = Socket_handler.new('challenge01.root-me.org', 52023)

socket_handler.open_socket
message = socket_handler.read_message

code = message.match(/'(.*?)'/)[1]

response = Base64.decode64(code)

socket_handler.send_value_and_close_socket(response)