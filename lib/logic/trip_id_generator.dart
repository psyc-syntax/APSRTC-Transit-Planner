

import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:planner_demo/logic/marks_algorithm.dart';

String generateTripId(Result result){

  final buffer = StringBuffer();

  for(final stop in result.path){
    buffer.write(stop.placeId);
    buffer.write("|");
    buffer.write(stop.oprsNo);
    buffer.write("|");
    buffer.write(stop.deptTime);
    buffer.write(";");
  }

  final hash = md5.convert(utf8.encode(buffer.toString())).toString();
  return hash.substring(0,16);
}

