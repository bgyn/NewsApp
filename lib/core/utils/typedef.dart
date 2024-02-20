import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/utils/faliure.dart';

typedef FutureEither<T> = Future<Either<Faliure, T>>;
typedef Futurevoid<T> = FutureEither<void>;
