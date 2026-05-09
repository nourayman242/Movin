// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   late IO.Socket socket;

//   void connect() {
//     socket = IO.io(
//       "https://movin-backend-production.up.railway.app",
//       {
//         "transports": ["websocket"],
//         "autoConnect": false,
//       },
//     );

//     socket.connect();

//     socket.onConnect((_) {
//       print("✅ Socket Connected");
//     });

//     socket.onDisconnect((_) {
//       print("❌ Socket Disconnected");
//     });

//     socket.onConnectError((err) {
//       print("❌ Connect Error: $err");
//     });
//   }
// }
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  /// ✅ Connect using token from SharedPreferences
  Future<void> connect() async {
    final token = await SharedHelper.getToken();

    if (token == null || token.isEmpty) {
      print("❌ Socket NOT connected: No access token found");
      return;
    }

    socket = IO.io(
      "https://movin-backend-production.up.railway.app",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({
            "token": token,
          })
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      print("✅ Socket Connected");
    });

    socket!.onDisconnect((_) {
      print("❌ Socket Disconnected");
    });

    socket!.onConnectError((err) {
      print("❌ Connect Error: $err");
    });

    socket!.onError((err) {
      print("❌ Socket Error: $err");
    });
  }

  /// ✅ Disconnect socket manually (Logout / app close)
  void disconnect() {
    if (socket != null) {
      socket!.disconnect();
      socket!.dispose();
      socket = null;
      print("🔌 Socket Disconnected & Disposed");
    }
  }

  /// ✅ Reconnect if token changed (after refresh or login)
  Future<void> reconnect() async {
    disconnect();
    await connect();
  }

  /// ✅ Check if socket is connected
  bool isConnected() {
    return socket != null && socket!.connected;
  }
}