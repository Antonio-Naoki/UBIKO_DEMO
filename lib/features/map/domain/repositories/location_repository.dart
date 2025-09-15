import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/features/map/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Either<Failure, Location>> getCurrentLocation();
}
