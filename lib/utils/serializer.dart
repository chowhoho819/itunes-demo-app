class FreezedSerializer {
  static T fromJson<T>(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonFunc) {
    return fromJsonFunc(json);
  }

  static Map<String, dynamic> toJson<T>(T object, Map<String, dynamic> Function(T) toJsonFunc) {
    return toJsonFunc(object);
  }
}
