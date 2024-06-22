# five_on_4_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)


## How to do db migrations
1. make sure version 1 schema exists
   1. wiuth migration 1
   2. if not, create it with maake generate_migrations_schema
2. make changes 
- add new table
- or add new column
- or change column type
- - or some such
1. increase "schemaVersion" on AppDatabase by 1
<!-- 2. run make generate --> -> maybe not this
3. run the following command
```
maake generate_migrations_schema
```
1. run the following command
```
make generate_migrations_steps
```
1. add next migration to migration_wrapper that matches your db modification. for example:
```
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        // await m.addColumn(schema.users, schema.users.nickname);
        await m.createTable(schema.matchEntity);
      },
      from2To3: (m, schema) async {
        // await m.createTable(schema.somethingElse);
        await m.addColumn(schema.matchEntity, schema.matchEntity.title);
      },
    ),

```
6. run the following command
```
make generate
```