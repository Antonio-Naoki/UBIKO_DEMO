import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/features/map/domain/entities/location.dart';
import 'package:myapp/features/map/domain/repositories/location_repository.dart';

class GetCurrentLocation {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);

  Future<Either<Failure, Location>> call() async {
    return await repository.getCurrentLocation();
  }
}
