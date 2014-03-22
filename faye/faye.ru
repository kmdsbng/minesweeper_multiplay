require 'faye'

class LoggingExtension
  def incoming(message, request, callback)
    p [request.ip, message]
    callback.call(message)
  end
end

Faye::WebSocket.load_adapter('thin')
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
faye_server.add_extension(LoggingExtension.new)
run faye_server

