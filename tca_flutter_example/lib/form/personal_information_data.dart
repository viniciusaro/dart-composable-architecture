part of 'personal_information.dart';

@KeyPathable()
final class PersonalInformationData with _$PersonalInformationData {
  @override
  final String? name;

  @override
  final String? email;

  @override
  final String? phone;

  const PersonalInformationData({
    this.name,
    this.email,
    this.phone, //
  });
}
