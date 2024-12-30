class DataPlaceHolder<T> {
  T? data;

  DataPlaceHolder({this.data});

  bool get hasData => data != null;
}
