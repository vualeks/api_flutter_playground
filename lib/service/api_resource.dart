import 'deserializable.dart';

class ApiResource<T extends Deserializable> {
  var status = ResourceStatus.idle;
  var error = '';
  T content;

  ApiResource(this.status, this.error, this.content);
  ApiResource.successfulData(this.content) {
    this.status = ResourceStatus.success;
  }
  ApiResource.status(this.status);
  ApiResource.statusData(this.status, this.content);

}

enum ResourceStatus {
  idle,
  loading,
  success,
  error
}