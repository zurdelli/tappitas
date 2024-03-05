// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tapa.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTapaCollection on Isar {
  IsarCollection<Tapa> get tapas => this.collection();
}

const TapaSchema = CollectionSchema(
  name: r'Tapa',
  id: 8386293865198199955,
  properties: {
    r'brewCountry': PropertySchema(
      id: 0,
      name: r'brewCountry',
      type: IsarType.string,
    ),
    r'brewCountryCode': PropertySchema(
      id: 1,
      name: r'brewCountryCode',
      type: IsarType.string,
    ),
    r'brewery': PropertySchema(
      id: 2,
      name: r'brewery',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 3,
      name: r'date',
      type: IsarType.string,
    ),
    r'imagen': PropertySchema(
      id: 4,
      name: r'imagen',
      type: IsarType.string,
    ),
    r'isFavorited': PropertySchema(
      id: 5,
      name: r'isFavorited',
      type: IsarType.long,
    ),
    r'model': PropertySchema(
      id: 6,
      name: r'model',
      type: IsarType.string,
    ),
    r'place': PropertySchema(
      id: 7,
      name: r'place',
      type: IsarType.string,
    ),
    r'primColor': PropertySchema(
      id: 8,
      name: r'primColor',
      type: IsarType.string,
    ),
    r'rating': PropertySchema(
      id: 9,
      name: r'rating',
      type: IsarType.double,
    ),
    r'secoColor': PropertySchema(
      id: 10,
      name: r'secoColor',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 11,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _tapaEstimateSize,
  serialize: _tapaSerialize,
  deserialize: _tapaDeserialize,
  deserializeProp: _tapaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tapaGetId,
  getLinks: _tapaGetLinks,
  attach: _tapaAttach,
  version: '3.1.0+1',
);

int _tapaEstimateSize(
  Tapa object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.brewCountry;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.brewCountryCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.brewery;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.date;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imagen;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.model;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.place;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.primColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.secoColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _tapaSerialize(
  Tapa object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.brewCountry);
  writer.writeString(offsets[1], object.brewCountryCode);
  writer.writeString(offsets[2], object.brewery);
  writer.writeString(offsets[3], object.date);
  writer.writeString(offsets[4], object.imagen);
  writer.writeLong(offsets[5], object.isFavorited);
  writer.writeString(offsets[6], object.model);
  writer.writeString(offsets[7], object.place);
  writer.writeString(offsets[8], object.primColor);
  writer.writeDouble(offsets[9], object.rating);
  writer.writeString(offsets[10], object.secoColor);
  writer.writeString(offsets[11], object.type);
}

Tapa _tapaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tapa();
  object.brewCountry = reader.readStringOrNull(offsets[0]);
  object.brewCountryCode = reader.readStringOrNull(offsets[1]);
  object.brewery = reader.readStringOrNull(offsets[2]);
  object.date = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.imagen = reader.readStringOrNull(offsets[4]);
  object.isFavorited = reader.readLongOrNull(offsets[5]);
  object.model = reader.readStringOrNull(offsets[6]);
  object.place = reader.readStringOrNull(offsets[7]);
  object.primColor = reader.readStringOrNull(offsets[8]);
  object.rating = reader.readDoubleOrNull(offsets[9]);
  object.secoColor = reader.readStringOrNull(offsets[10]);
  object.type = reader.readStringOrNull(offsets[11]);
  return object;
}

P _tapaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tapaGetId(Tapa object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tapaGetLinks(Tapa object) {
  return [];
}

void _tapaAttach(IsarCollection<dynamic> col, Id id, Tapa object) {
  object.id = id;
}

extension TapaQueryWhereSort on QueryBuilder<Tapa, Tapa, QWhere> {
  QueryBuilder<Tapa, Tapa, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TapaQueryWhere on QueryBuilder<Tapa, Tapa, QWhereClause> {
  QueryBuilder<Tapa, Tapa, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Tapa, Tapa, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterWhereClause> idBetween(
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

extension TapaQueryFilter on QueryBuilder<Tapa, Tapa, QFilterCondition> {
  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'brewCountry',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'brewCountry',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brewCountry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brewCountry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brewCountry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brewCountry',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brewCountry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brewCountry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brewCountry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brewCountry',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brewCountry',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brewCountry',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'brewCountryCode',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'brewCountryCode',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brewCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brewCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brewCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brewCountryCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brewCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brewCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brewCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brewCountryCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brewCountryCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> brewCountryCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brewCountryCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'brewery',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'brewery',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brewery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brewery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brewery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brewery',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brewery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brewery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brewery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brewery',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brewery',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> breweryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brewery',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagen',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagen',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagen',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> imagenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagen',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> isFavoritedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFavorited',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> isFavoritedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFavorited',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> isFavoritedEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorited',
        value: value,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> isFavoritedGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isFavorited',
        value: value,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> isFavoritedLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isFavorited',
        value: value,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> isFavoritedBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isFavorited',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'model',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'model',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> modelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'place',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'place',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'place',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'place',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'place',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'place',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'place',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'place',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'place',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'place',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'place',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> placeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'place',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'primColor',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'primColor',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'primColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'primColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'primColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'primColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> primColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'primColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> ratingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> ratingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> ratingEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> ratingGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> ratingLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> ratingBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secoColor',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secoColor',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secoColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secoColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secoColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> secoColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secoColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension TapaQueryObject on QueryBuilder<Tapa, Tapa, QFilterCondition> {}

extension TapaQueryLinks on QueryBuilder<Tapa, Tapa, QFilterCondition> {}

extension TapaQuerySortBy on QueryBuilder<Tapa, Tapa, QSortBy> {
  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByBrewCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewCountry', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByBrewCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewCountry', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByBrewCountryCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewCountryCode', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByBrewCountryCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewCountryCode', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByBrewery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewery', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByBreweryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewery', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByImagen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByImagenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByIsFavorited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorited', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByIsFavoritedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorited', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByPlace() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'place', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByPlaceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'place', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByPrimColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primColor', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByPrimColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primColor', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortBySecoColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secoColor', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortBySecoColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secoColor', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension TapaQuerySortThenBy on QueryBuilder<Tapa, Tapa, QSortThenBy> {
  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByBrewCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewCountry', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByBrewCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewCountry', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByBrewCountryCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewCountryCode', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByBrewCountryCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewCountryCode', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByBrewery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewery', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByBreweryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brewery', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByImagen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByImagenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByIsFavorited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorited', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByIsFavoritedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorited', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByPlace() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'place', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByPlaceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'place', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByPrimColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primColor', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByPrimColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primColor', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenBySecoColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secoColor', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenBySecoColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secoColor', Sort.desc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Tapa, Tapa, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension TapaQueryWhereDistinct on QueryBuilder<Tapa, Tapa, QDistinct> {
  QueryBuilder<Tapa, Tapa, QDistinct> distinctByBrewCountry(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brewCountry', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByBrewCountryCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brewCountryCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByBrewery(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brewery', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByImagen(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagen', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByIsFavorited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorited');
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByModel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByPlace(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'place', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByPrimColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primColor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctBySecoColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secoColor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tapa, Tapa, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension TapaQueryProperty on QueryBuilder<Tapa, Tapa, QQueryProperty> {
  QueryBuilder<Tapa, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> brewCountryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brewCountry');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> brewCountryCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brewCountryCode');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> breweryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brewery');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> imagenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagen');
    });
  }

  QueryBuilder<Tapa, int?, QQueryOperations> isFavoritedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorited');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> modelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> placeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'place');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> primColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primColor');
    });
  }

  QueryBuilder<Tapa, double?, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> secoColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secoColor');
    });
  }

  QueryBuilder<Tapa, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
