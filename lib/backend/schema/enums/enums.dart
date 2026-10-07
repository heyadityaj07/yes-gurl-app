import 'package:collection/collection.dart';

enum CommunityType {
  open,
  closed,
  invite,
}

enum InvitationStatus {
  pending,
  accepted,
  declined,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (CommunityType):
      return CommunityType.values.deserialize(value) as T?;
    case (InvitationStatus):
      return InvitationStatus.values.deserialize(value) as T?;
    default:
      return null;
  }
}
