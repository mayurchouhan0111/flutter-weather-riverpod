import 'package:dartz/dartz.dart';
import 'package:angryflutter/weather/core/error/exceptions.dart';
import 'package:angryflutter/weather/core/error/failures.dart';
import 'package:angryflutter/weather/data/datasources/local/weather_local_datasource.dart';
import 'package:angryflutter/weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:angryflutter/weather/domain/entities/weather_entity.dart';
import 'package:angryflutter/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async {
    try {
      final remoteWeather = await remoteDataSource.getCurrentWeather(cityName);
      localDataSource.cacheWeather(remoteWeather);
      return Right(remoteWeather);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
