import 'dart:async';
/**
 * Stream包装类
 */
class ExStream<T> {
  StreamController<T> _stream;
  ExStream() {
    this._stream = StreamController<T>();
  }
  ExStream.broadcast() {
    this._stream =StreamController<T>.broadcast();
  }

  Stream<T> get stream => this._stream.stream;
  StreamSink<T> get sink => this._stream.sink;

  void setData(T data) {
    this.sink.add(data);
  }
}