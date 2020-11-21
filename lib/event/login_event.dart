import 'package:event_bus/event_bus.dart';

EventBus loginEventBus = EventBus();

class LoginEvent {
  bool isLogin;
  String id;
  String url;

  LoginEvent(this.isLogin, {this.id, this.url});
}
