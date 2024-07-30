import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketCustomer {
  static final SocketCustomer _singleton = SocketCustomer._internal();

  SocketCustomer._internal();

  factory SocketCustomer() {
    return _singleton;
  }

  late IO.Socket socket;

  void connect() async {
    try {
      socket = IO.io('https://main.doapp.vn:6441', <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });

      socket.connect();
      socket.onConnect((data) => print("on conected >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"));
      // socket.onDisconnect((_) => print('disconnect'));
    } catch (err) {
      print(err);
    }
  }

  void listenCustomerWithId(int? idCustomer, Function getData) {
    socket.on('chat:message_from_customer:$idCustomer', (data) async {
      getData(data);
    });
  }

  void listenUser(int? idCustomer, Function getData) {
    socket.on('chat:message_from_user:$idCustomer', (data) async {
      getData(data);
    });
  }

  void listenCustomer(Function getData) {
    socket.on('chat:message_from_customer', (data) async {
      getData(data);
    });
  }

  void close() {
    print("==========================close");
    socket.clearListeners();
    socket.close();
  }

  ///

  void listenFriendWithId(int? myId,int? customerId, Function getData) {
    socket.on('chat:message_from_customer_to_customer:$customerId:$myId', (data) async {
      getData(data);
    });
  }
}
