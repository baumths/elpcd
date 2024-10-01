## [2.0.0]

### Features

- Retention and Disposal table visualization
- Search for classes by code and name
- I18n (Internationalization) setup. The app is now available in Portuguese,
  English and Spanish. The language is automatically detected based on the
  users' system configuration.
- [WIP] Import and Export app data as JSON for backups/sharing

### Changes

- Refactored and restructured the whole app removing dependencies and improving
  the performance of many algorithms.
- Reworked the Class form screen to present the entire metadata form instead
  of having to add and remove the desired metadata through a picker dialog.
- Changed the mandatory fields in the class form to normal fields. It's now
  possible to create classes without providing the code and name fields right
  away.
- The CSV export file now includes an _archivistNote_ column with an entry for
  the Fonds row which states that the classification scheme was created on the
  El PCD software.
- The columns _legacyId_ and _parentId_ of the CSV export file now start from
  _1_ instead of _-1_. This fixes a bug where a class whose _parentId_ is _0_
  would be imported by AtoM as a top level description, breaking the hierarchy.
- Added a new app logo & loading screen
- Updated the app theme to use Material 3

### Dependencies

- Upgraded Dart & Flutter to the latest versions (Dart 3.5 & Flutter 3.24)
- Upgraded most dependencies to the latest versions available
- Switched the library that provides the TreeView widget to a newer one
  maintained by the Flutter team.

## [1.0.0]

Initial Release
