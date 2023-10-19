typedef AsyncResult<S, F> = Future<Result<S, F>>;

sealed class Result<S, F> {
  bool get isFailure;
  bool get isSuccess;

  R when<R>({
    required R Function(S value) success,
    required R Function(F value) failure,
  });
}

final class Success<S, F> implements Result<S, F> {
  const Success(this.value);

  final S value;

  @override
  bool get isFailure => false;

  @override
  bool get isSuccess => true;

  @override
  R when<R>({
    required R Function(S value) success,
    required R Function(F value) failure,
  }) {
    return success(value);
  }
}

final class Failure<S, F> implements Result<S, F> {
  const Failure(this.value);

  final F value;

  @override
  bool get isFailure => true;

  @override
  bool get isSuccess => false;

  @override
  R when<R>({
    required R Function(S value) success,
    required R Function(F value) failure,
  }) {
    return failure(value);
  }
}
