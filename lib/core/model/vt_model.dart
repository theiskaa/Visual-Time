//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

abstract class VTModel {
  // Constructor for setting data.
  const VTModel();

  // Set data from jsonDecode.
  const VTModel.fromJson(Map<String, dynamic> json);

  // Get data to json format.
  Map<String, dynamic> toJson();

  // A decorator for concrete model.
  dynamic copyWith();
}
