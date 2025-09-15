import 'package:get_it/get_it.dart';
import 'package:myapp/core/utils/di.dart' as di;

final sl = GetIt.instance;

Future<void> init() async {
  di.init();
}
