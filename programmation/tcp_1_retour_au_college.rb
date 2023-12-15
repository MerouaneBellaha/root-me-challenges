require_relative 'tcp_socket_handler'

socket_handler = Socket_handler.new('challenge01.root-me.org', 52002)

socket_handler.open_socket

message = socket_handler.read_message

numbers = message.scan(/\d+/).map(&:to_i)

socket_handler.send_value_and_close_socket((Math.sqrt(numbers[1]) * numbers[2]).round(2))