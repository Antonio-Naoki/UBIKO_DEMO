import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/features/map/data/datasources/location_local_data_source.dart';
import 'package:myapp/features/map/domain/entities/location.dart';
import 'package:myapp/features/map/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource localDataSource;

  LocationRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Location>> getCurrentLocation() async {
    try {
      final position = await localDataSource.getCurrentLocation();
      return Right(Location(latitude: position.latitude, longitude: position.longitude));
    } catch (e) {
      log('Error getting location in repository: $e');
      return Left(ServerFailure());
    }
  }
}
