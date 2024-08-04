// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'player_local_entity.dart';

// // **************************************************************************
// // IsarCollectionGenerator
// // **************************************************************************

// // coverage:ignore-file
// // ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

// extension GetPlayerLocalEntityCollection on Isar {
//   IsarCollection<PlayerLocalEntity> get playerLocalEntitys => this.collection();
// }

// const PlayerLocalEntitySchema = CollectionSchema(
//   name: r'PlayerLocalEntity',
//   id: -527625426859127704,
//   properties: {
//     r'firstName': PropertySchema(
//       id: 0,
//       name: r'firstName',
//       type: IsarType.string,
//     ),
//     r'lastName': PropertySchema(
//       id: 1,
//       name: r'lastName',
//       type: IsarType.string,
//     ),
//     r'nickname': PropertySchema(
//       id: 2,
//       name: r'nickname',
//       type: IsarType.string,
//     )
//   },
//   estimateSize: _playerLocalEntityEstimateSize,
//   serialize: _playerLocalEntitySerialize,
//   deserialize: _playerLocalEntityDeserialize,
//   deserializeProp: _playerLocalEntityDeserializeProp,
//   idName: r'id',
//   indexes: {},
//   links: {},
//   embeddedSchemas: {},
//   getId: _playerLocalEntityGetId,
//   getLinks: _playerLocalEntityGetLinks,
//   attach: _playerLocalEntityAttach,
//   version: '3.1.0+1',
// );

// int _playerLocalEntityEstimateSize(
//   PlayerLocalEntity object,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   var bytesCount = offsets.last;
//   bytesCount += 3 + object.firstName.length * 3;
//   bytesCount += 3 + object.lastName.length * 3;
//   bytesCount += 3 + object.nickname.length * 3;
//   return bytesCount;
// }

// void _playerLocalEntitySerialize(
//   PlayerLocalEntity object,
//   IsarWriter writer,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   writer.writeString(offsets[0], object.firstName);
//   writer.writeString(offsets[1], object.lastName);
//   writer.writeString(offsets[2], object.nickname);
// }

// PlayerLocalEntity _playerLocalEntityDeserialize(
//   Id id,
//   IsarReader reader,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   final object = PlayerLocalEntity(
//     firstName: reader.readString(offsets[0]),
//     id: id,
//     lastName: reader.readString(offsets[1]),
//     nickname: reader.readString(offsets[2]),
//   );
//   return object;
// }

// P _playerLocalEntityDeserializeProp<P>(
//   IsarReader reader,
//   int propertyId,
//   int offset,
//   Map<Type, List<int>> allOffsets,
// ) {
//   switch (propertyId) {
//     case 0:
//       return (reader.readString(offset)) as P;
//     case 1:
//       return (reader.readString(offset)) as P;
//     case 2:
//       return (reader.readString(offset)) as P;
//     default:
//       throw IsarError('Unknown property with id $propertyId');
//   }
// }

// Id _playerLocalEntityGetId(PlayerLocalEntity object) {
//   return object.id;
// }

// List<IsarLinkBase<dynamic>> _playerLocalEntityGetLinks(
//     PlayerLocalEntity object) {
//   return [];
// }

// void _playerLocalEntityAttach(
//     IsarCollection<dynamic> col, Id id, PlayerLocalEntity object) {}

// extension PlayerLocalEntityQueryWhereSort
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QWhere> {
//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterWhere> anyId() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(const IdWhereClause.any());
//     });
//   }
// }

// extension PlayerLocalEntityQueryWhere
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QWhereClause> {
//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterWhereClause>
//       idEqualTo(Id id) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: id,
//         upper: id,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterWhereClause>
//       idNotEqualTo(Id id) {
//     return QueryBuilder.apply(this, (query) {
//       if (query.whereSort == Sort.asc) {
//         return query
//             .addWhereClause(
//               IdWhereClause.lessThan(upper: id, includeUpper: false),
//             )
//             .addWhereClause(
//               IdWhereClause.greaterThan(lower: id, includeLower: false),
//             );
//       } else {
//         return query
//             .addWhereClause(
//               IdWhereClause.greaterThan(lower: id, includeLower: false),
//             )
//             .addWhereClause(
//               IdWhereClause.lessThan(upper: id, includeUpper: false),
//             );
//       }
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterWhereClause>
//       idGreaterThan(Id id, {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.greaterThan(lower: id, includeLower: include),
//       );
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterWhereClause>
//       idLessThan(Id id, {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.lessThan(upper: id, includeUpper: include),
//       );
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterWhereClause>
//       idBetween(
//     Id lowerId,
//     Id upperId, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: lowerId,
//         includeLower: includeLower,
//         upper: upperId,
//         includeUpper: includeUpper,
//       ));
//     });
//   }
// }

// extension PlayerLocalEntityQueryFilter
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QFilterCondition> {
//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'firstName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'firstName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'firstName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'firstName',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'firstName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'firstName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'firstName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'firstName',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'firstName',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       firstNameIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'firstName',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       idEqualTo(Id value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       idGreaterThan(
//     Id value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       idLessThan(
//     Id value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       idBetween(
//     Id lower,
//     Id upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'id',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'lastName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'lastName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'lastName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'lastName',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'lastName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'lastName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'lastName',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'lastName',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'lastName',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       lastNameIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'lastName',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'nickname',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'nickname',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'nickname',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'nickname',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'nickname',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'nickname',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'nickname',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'nickname',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'nickname',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterFilterCondition>
//       nicknameIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'nickname',
//         value: '',
//       ));
//     });
//   }
// }

// extension PlayerLocalEntityQueryObject
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QFilterCondition> {}

// extension PlayerLocalEntityQueryLinks
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QFilterCondition> {}

// extension PlayerLocalEntityQuerySortBy
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QSortBy> {
//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       sortByFirstName() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'firstName', Sort.asc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       sortByFirstNameDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'firstName', Sort.desc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       sortByLastName() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'lastName', Sort.asc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       sortByLastNameDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'lastName', Sort.desc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       sortByNickname() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'nickname', Sort.asc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       sortByNicknameDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'nickname', Sort.desc);
//     });
//   }
// }

// extension PlayerLocalEntityQuerySortThenBy
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QSortThenBy> {
//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       thenByFirstName() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'firstName', Sort.asc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       thenByFirstNameDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'firstName', Sort.desc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy> thenById() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.asc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       thenByIdDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.desc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       thenByLastName() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'lastName', Sort.asc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       thenByLastNameDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'lastName', Sort.desc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       thenByNickname() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'nickname', Sort.asc);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QAfterSortBy>
//       thenByNicknameDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'nickname', Sort.desc);
//     });
//   }
// }

// extension PlayerLocalEntityQueryWhereDistinct
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QDistinct> {
//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QDistinct>
//       distinctByFirstName({bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'firstName', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QDistinct>
//       distinctByLastName({bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'lastName', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QDistinct>
//       distinctByNickname({bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'nickname', caseSensitive: caseSensitive);
//     });
//   }
// }

// extension PlayerLocalEntityQueryProperty
//     on QueryBuilder<PlayerLocalEntity, PlayerLocalEntity, QQueryProperty> {
//   QueryBuilder<PlayerLocalEntity, int, QQueryOperations> idProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'id');
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, String, QQueryOperations>
//       firstNameProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'firstName');
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, String, QQueryOperations> lastNameProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'lastName');
//     });
//   }

//   QueryBuilder<PlayerLocalEntity, String, QQueryOperations> nicknameProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'nickname');
//     });
//   }
// }
