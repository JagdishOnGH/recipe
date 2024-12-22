class PlaceHolder<T> {
  T? data;

  PlaceHolder({this.data});

  bool get hasData => data != null;
}
