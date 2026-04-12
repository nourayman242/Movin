import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io(
      "https://movin-backend.fly.dev",
      {
        "transports": ["websocket"],
        "autoConnect": false,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      print("✅ Socket Connected");
    });

    socket.onDisconnect((_) {
      print("❌ Socket Disconnected");
    });

    socket.onConnectError((err) {
      print("❌ Connect Error: $err");
    });
  }
}