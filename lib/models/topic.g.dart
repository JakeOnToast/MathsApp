// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConstantTopicDataAdapter extends TypeAdapter<ConstantTopicData> {
  @override
  final int typeId = 2;

  @override
  ConstantTopicData read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ConstantTopicData.addition;
      case 1:
        return ConstantTopicData.subtraction;
      case 2:
        return ConstantTopicData.multiplication;
      case 3:
        return ConstantTopicData.division;
      case 4:
        return ConstantTopicData.exponents;
      case 5:
        return ConstantTopicData.roots;
      case 6:
        return ConstantTopicData.fake;
      default:
        return ConstantTopicData.addition;
    }
  }

  @override
  void write(BinaryWriter writer, ConstantTopicData obj) {
    switch (obj) {
      case ConstantTopicData.addition:
        writer.writeByte(0);
        break;
      case ConstantTopicData.subtraction:
        writer.writeByte(1);
        break;
      case ConstantTopicData.multiplication:
        writer.writeByte(2);
        break;
      case ConstantTopicData.division:
        writer.writeByte(3);
        break;
      case ConstantTopicData.exponents:
        writer.writeByte(4);
        break;
      case ConstantTopicData.roots:
        writer.writeByte(5);
        break;
      case ConstantTopicData.fake:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConstantTopicDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TopicAdapter extends TypeAdapter<Topic> {
  @override
  final int typeId = 1;

  @override
  Topic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Topic(
      topicData: fields[0] as ConstantTopicData,
    )
      .._selectedLevel = fields[1] as int
      .._maxLevelUnlocked = fields[2] as int
      .._endlessHighScore = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, Topic obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.topicData)
      ..writeByte(1)
      ..write(obj._selectedLevel)
      ..writeByte(2)
      ..write(obj._maxLevelUnlocked)
      ..writeByte(3)
      ..write(obj._endlessHighScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
