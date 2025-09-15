import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/features/map/data/datasources/location_local_data_source.dart';
import 'package:myapp/features/map/data/repositories/location_repository_impl.dart';
import 'package:myapp/features/map/domain/repositories/location_repository.dart';
import 'package:myapp/features/map/domain/usecases/get_current_location.dart';
import 'package:myapp/features/map/presentation/bloc/map_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => MapBloc(getCurrentLocation: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCurrentLocation(sl()));

  // Repository
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LocationLocalDataSource>(
    () => LocationLocalDataSourceImpl(),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
