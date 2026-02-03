import 'dart:async';

abstract class IDataSource<T, R extends Object> {
  FutureOr<T> call(R params);
}
