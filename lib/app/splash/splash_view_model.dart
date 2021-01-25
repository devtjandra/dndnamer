import 'package:dndnamer/app/splash/splash_client.dart';
import 'package:flutter_riverpod/all.dart';

class SplashViewModel {
  final ProviderReference ref;
  final client = SplashClient();

  SplashViewModel(this.ref) : super();

  Future<void> initialise() async {
    
  }
}