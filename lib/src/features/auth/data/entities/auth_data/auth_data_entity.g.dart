// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAuthDataEntityCollection on Isar {
  IsarCollection<AuthDataEntity> get authDataEntitys => this.collection();
}

const AuthDataEntitySchema = CollectionSchema(
  name: r'AuthDataEntity',
  id: -6809777986754037891,
  properties: {
    r'playerInfo': PropertySchema(
      id: 0,
      name: r'playerInfo',
      type: IsarType.object,
      target: r'AuthDataPlayerInfoEntity',
    ),
    r'teamInfo': PropertySchema(
      id: 1,
      name: r'teamInfo',
      type: IsarType.object,
      target: r'AuthDataTeamInfoEntity',
    )
  },
  estimateSize: _authDataEntityEstimateSize,
  serialize: _authDataEntitySerialize,
  deserialize: _authDataEntityDeserialize,
  deserializeProp: _authDataEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'AuthDataPlayerInfoEntity': AuthDataPlayerInfoEntitySchema,
    r'AuthDataTeamInfoEntity': AuthDataTeamInfoEntitySchema
  },
  getId: _authDataEntityGetId,
  getLinks: _authDataEntityGetLinks,
  attach: _authDataEntityAttach,
  version: '3.1.0+1',
);

int _authDataEntityEstimateSize(
  AuthDataEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      AuthDataPlayerInfoEntitySchema.estimateSize(
          object.playerInfo, allOffsets[AuthDataPlayerInfoEntity]!, allOffsets);
  bytesCount += 3 +
      AuthDataTeamInfoEntitySchema.estimateSize(
          object.teamInfo, allOffsets[AuthDataTeamInfoEntity]!, allOffsets);
  return bytesCount;
}

void _authDataEntitySerialize(
  AuthDataEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<AuthDataPlayerInfoEntity>(
    offsets[0],
    allOffsets,
    AuthDataPlayerInfoEntitySchema.serialize,
    object.playerInfo,
  );
  writer.writeObject<AuthDataTeamInfoEntity>(
    offsets[1],
    allOffsets,
    AuthDataTeamInfoEntitySchema.serialize,
    object.teamInfo,
  );
}

AuthDataEntity _authDataEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AuthDataEntity(
    playerInfo: reader.readObjectOrNull<AuthDataPlayerInfoEntity>(
          offsets[0],
          AuthDataPlayerInfoEntitySchema.deserialize,
          allOffsets,
        ) ??
        AuthDataPlayerInfoEntity(),
    teamInfo: reader.readObjectOrNull<AuthDataTeamInfoEntity>(
          offsets[1],
          AuthDataTeamInfoEntitySchema.deserialize,
          allOffsets,
        ) ??
        AuthDataTeamInfoEntity(),
  );
  return object;
}

P _authDataEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<AuthDataPlayerInfoEntity>(
            offset,
            AuthDataPlayerInfoEntitySchema.deserialize,
            allOffsets,
          ) ??
          AuthDataPlayerInfoEntity()) as P;
    case 1:
      return (reader.readObjectOrNull<AuthDataTeamInfoEntity>(
            offset,
            AuthDataTeamInfoEntitySchema.deserialize,
            allOffsets,
          ) ??
          AuthDataTeamInfoEntity()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _authDataEntityGetId(AuthDataEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _authDataEntityGetLinks(AuthDataEntity object) {
  return [];
}

void _authDataEntityAttach(
    IsarCollection<dynamic> col, Id id, AuthDataEntity object) {}

extension AuthDataEntityQueryWhereSort
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QWhere> {
  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AuthDataEntityQueryWhere
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QWhereClause> {
  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AuthDataEntityQueryFilter
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QFilterCondition> {
  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AuthDataEntityQueryObject
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QFilterCondition> {
  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterFilterCondition>
      playerInfo(FilterQuery<AuthDataPlayerInfoEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'playerInfo');
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterFilterCondition> teamInfo(
      FilterQuery<AuthDataTeamInfoEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'teamInfo');
    });
  }
}

extension AuthDataEntityQueryLinks
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QFilterCondition> {}

extension AuthDataEntityQuerySortBy
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QSortBy> {}

extension AuthDataEntityQuerySortThenBy
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QSortThenBy> {
  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension AuthDataEntityQueryWhereDistinct
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QDistinct> {}

extension AuthDataEntityQueryProperty
    on QueryBuilder<AuthDataEntity, AuthDataEntity, QQueryProperty> {
  QueryBuilder<AuthDataEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataPlayerInfoEntity, QQueryOperations>
      playerInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerInfo');
    });
  }

  QueryBuilder<AuthDataEntity, AuthDataTeamInfoEntity, QQueryOperations>
      teamInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamInfo');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AuthDataPlayerInfoEntitySchema = Schema(
  name: r'AuthDataPlayerInfoEntity',
  id: -8281041840987557458,
  properties: {
    r'firstName': PropertySchema(
      id: 0,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.long,
    ),
    r'lastName': PropertySchema(
      id: 2,
      name: r'lastName',
      type: IsarType.string,
    ),
    r'nickName': PropertySchema(
      id: 3,
      name: r'nickName',
      type: IsarType.string,
    )
  },
  estimateSize: _authDataPlayerInfoEntityEstimateSize,
  serialize: _authDataPlayerInfoEntitySerialize,
  deserialize: _authDataPlayerInfoEntityDeserialize,
  deserializeProp: _authDataPlayerInfoEntityDeserializeProp,
);

int _authDataPlayerInfoEntityEstimateSize(
  AuthDataPlayerInfoEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.firstName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nickName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _authDataPlayerInfoEntitySerialize(
  AuthDataPlayerInfoEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.firstName);
  writer.writeLong(offsets[1], object.id);
  writer.writeString(offsets[2], object.lastName);
  writer.writeString(offsets[3], object.nickName);
}

AuthDataPlayerInfoEntity _authDataPlayerInfoEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AuthDataPlayerInfoEntity(
    firstName: reader.readStringOrNull(offsets[0]),
    id: reader.readLongOrNull(offsets[1]),
    lastName: reader.readStringOrNull(offsets[2]),
    nickName: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _authDataPlayerInfoEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AuthDataPlayerInfoEntityQueryFilter on QueryBuilder<
    AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity, QFilterCondition> {
  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firstName',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firstName',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
          QAfterFilterCondition>
      firstNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
          QAfterFilterCondition>
      firstNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> firstNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> idEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastName',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastName',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
          QAfterFilterCondition>
      lastNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
          QAfterFilterCondition>
      lastNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> lastNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nickName',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nickName',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nickName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
          QAfterFilterCondition>
      nickNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
          QAfterFilterCondition>
      nickNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nickName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickName',
        value: '',
      ));
    });
  }

  QueryBuilder<AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity,
      QAfterFilterCondition> nickNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nickName',
        value: '',
      ));
    });
  }
}

extension AuthDataPlayerInfoEntityQueryObject on QueryBuilder<
    AuthDataPlayerInfoEntity, AuthDataPlayerInfoEntity, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AuthDataTeamInfoEntitySchema = Schema(
  name: r'AuthDataTeamInfoEntity',
  id: -3999520107821948150,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.long,
    ),
    r'teamName': PropertySchema(
      id: 1,
      name: r'teamName',
      type: IsarType.string,
    )
  },
  estimateSize: _authDataTeamInfoEntityEstimateSize,
  serialize: _authDataTeamInfoEntitySerialize,
  deserialize: _authDataTeamInfoEntityDeserialize,
  deserializeProp: _authDataTeamInfoEntityDeserializeProp,
);

int _authDataTeamInfoEntityEstimateSize(
  AuthDataTeamInfoEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.teamName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _authDataTeamInfoEntitySerialize(
  AuthDataTeamInfoEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.id);
  writer.writeString(offsets[1], object.teamName);
}

AuthDataTeamInfoEntity _authDataTeamInfoEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AuthDataTeamInfoEntity(
    id: reader.readLongOrNull(offsets[0]),
    teamName: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _authDataTeamInfoEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AuthDataTeamInfoEntityQueryFilter on QueryBuilder<
    AuthDataTeamInfoEntity, AuthDataTeamInfoEntity, QFilterCondition> {
  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> idEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teamName',
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teamName',
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teamName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
          QAfterFilterCondition>
      teamNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
          QAfterFilterCondition>
      teamNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teamName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamName',
        value: '',
      ));
    });
  }

  QueryBuilder<AuthDataTeamInfoEntity, AuthDataTeamInfoEntity,
      QAfterFilterCondition> teamNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teamName',
        value: '',
      ));
    });
  }
}

extension AuthDataTeamInfoEntityQueryObject on QueryBuilder<
    AuthDataTeamInfoEntity, AuthDataTeamInfoEntity, QFilterCondition> {}
