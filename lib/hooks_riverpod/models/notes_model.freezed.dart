// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotesModel {

 int get id; String get body; DateTime get createdAt;
/// Create a copy of NotesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotesModelCopyWith<NotesModel> get copyWith => _$NotesModelCopyWithImpl<NotesModel>(this as NotesModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesModel&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,body,createdAt);

@override
String toString() {
  return 'NotesModel(id: $id, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $NotesModelCopyWith<$Res>  {
  factory $NotesModelCopyWith(NotesModel value, $Res Function(NotesModel) _then) = _$NotesModelCopyWithImpl;
@useResult
$Res call({
 int id, String body, DateTime createdAt
});




}
/// @nodoc
class _$NotesModelCopyWithImpl<$Res>
    implements $NotesModelCopyWith<$Res> {
  _$NotesModelCopyWithImpl(this._self, this._then);

  final NotesModel _self;
  final $Res Function(NotesModel) _then;

/// Create a copy of NotesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? body = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _NotesModel extends NotesModel {
  const _NotesModel(this.id, this.body, this.createdAt): super._();
  

@override final  int id;
@override final  String body;
@override final  DateTime createdAt;

/// Create a copy of NotesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotesModelCopyWith<_NotesModel> get copyWith => __$NotesModelCopyWithImpl<_NotesModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotesModel&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,body,createdAt);

@override
String toString() {
  return 'NotesModel(id: $id, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NotesModelCopyWith<$Res> implements $NotesModelCopyWith<$Res> {
  factory _$NotesModelCopyWith(_NotesModel value, $Res Function(_NotesModel) _then) = __$NotesModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String body, DateTime createdAt
});




}
/// @nodoc
class __$NotesModelCopyWithImpl<$Res>
    implements _$NotesModelCopyWith<$Res> {
  __$NotesModelCopyWithImpl(this._self, this._then);

  final _NotesModel _self;
  final $Res Function(_NotesModel) _then;

/// Create a copy of NotesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? createdAt = null,}) {
  return _then(_NotesModel(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
