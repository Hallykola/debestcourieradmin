enum status { success, fail }

class Response {
  status? type;
  dynamic data;
  setType(status status) {
    type = status;
  }

  setData(dynamic data) {
    this.data = data;
  }

  getType() => type;
  getData() => data;
}
