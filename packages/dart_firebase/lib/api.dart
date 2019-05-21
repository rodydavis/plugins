library dart_firebase;

import 'dart:async';
import 'dart:convert';

import 'package:dart_firebase/utils/push_id_generator.dart';

import 'src/impl/unsupported.dart'
    if (dart.library.html) 'src/impl/browser.dart'
    if (dart.library.io) 'src/impl/io.dart';

part 'src/client.dart';
part 'src/endpoints.dart';
part 'src/token.dart';
part 'src/types/firestore/collection_reference.dart';
part 'src/types/firestore/document_reference.dart';
part 'src/types/firestore/document_snapshot.dart';
part 'src/types/firestore/reference.dart';
part 'src/types/object.dart';
