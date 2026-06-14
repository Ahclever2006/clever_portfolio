import 'package:clever_portfolio/core/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Global service locator.
final GetIt getIt = GetIt.instance;

/// Wires all `@injectable` registrations (codegen in `injection.config.dart`).
/// Awaits `@preResolve` dependencies (e.g. SharedPreferences).
@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
}
