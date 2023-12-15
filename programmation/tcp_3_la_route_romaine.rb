require_relative 'tcp_socket_handler'

socket_handler = Socket_handler.new('challenge01.root-me.org', 52021)

socket_handler.open_socket
message = socket_handler.read_message

code = message.match(/'(.*?)'/)[1]
puts code

response = code.tr('A-Za-z', 'N-ZA-Mn-za-m')

socket_handler.send_value_and_close_socket(response)