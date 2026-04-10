import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io(
      "https://movin-backend.fly.dev",
      {
        "transports": ["websocket"],
        "autoConnect": true,
      },
    );

    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }
}