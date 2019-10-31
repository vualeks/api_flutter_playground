abstract class Deserializable<T> {
  T getFromJson(Map<String, dynamic> map);
}