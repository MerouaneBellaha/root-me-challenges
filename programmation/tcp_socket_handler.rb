require 'socket'

class Socket_handler
  socket = nil

  def initialize(hostname, port)
    @hostname = hostname
    @port = port
  end

  def open_socket
    $socket = TCPSocket.open(@hostname, @port)
  end
  
  def read_message
    ready = IO.select([$socket])
    if ready
      message = $socket.read_nonblock(1024, exception: false)
      puts "message received #{message}"
      return message
    end
    return nil
  end
  
  def send_value_and_close_socket(value)
    $socket.puts value
    
    reponse = $socket.gets.chomp
    
    puts "server response #{reponse}"
    
    $socket.close
  end

  def send_value(value)
    $socket.puts value
  end

  def close_socket
    $socket.close
  end
end