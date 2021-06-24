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
