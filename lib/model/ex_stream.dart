import 'dart:async';
/**
 * Stream包装类
 */
class ExStream<T> {
  StreamController<T> _stream;
  T _data;
  ExStream(T data) {
    this._stream = StreamController<T>();
    this._data = data;
  }
  ExStream.broadcast(T data) {
    this._stream =StreamController<T>.broadcast();
    this._data = data;
  }

  Stream<T> get stream => this._stream.stream;
  StreamSink<T> get sink => this._stream.sink;

  T get data => this._data;
  void setData(T data) {
    this._data = data;
    this.sink.add(data);
  }

  void dispose() {
    this.sink.close();
    this._stream.close();
  }
}