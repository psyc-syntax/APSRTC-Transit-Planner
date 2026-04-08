import 'package:planner_demo/models/bus_stop.dart';
import 'package:planner_demo/models/bus_trip.dart';

List<BusStop> busStops = [

  BusStop(
    id: "BS001",
    name: "Vijayawada",
    code: "VJA",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 40,
    facilities: ["Waiting Hall","Food Court","Restrooms","Ticket Counter"],
    latitude: 16.5062,
    longitude: 80.6480,
    address: [
      "520010",
      "NTR District",
      "Benz Circle",
      "Vijayawada",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS002",
    name: "Guntur",
    code: "GNT",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 35,
    facilities: ["Waiting Hall","Drinking Water","Restrooms"],
    latitude: 16.3067,
    longitude: 80.4365,
    address: [
      "522002",
      "Guntur District",
      "Arundelpet",
      "Guntur",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS003",
    name: "Tenali",
    code: "TNL",
    hubType: Hub.local,
    isDistrictHQ: false,
    platfroms: 12,
    facilities: ["Shelter","Drinking Water"],
    latitude: 16.2390,
    longitude: 80.6400,
    address: [
      "522201",
      "Guntur District",
      "Railway Station Road",
      "Tenali",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS004",
    name: "Ongole",
    code: "OGL",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 28,
    facilities: ["Waiting Hall","Food Stalls","Restrooms"],
    latitude: 15.5057,
    longitude: 80.0499,
    address: [
      "523001",
      "Prakasam District",
      "Trunk Road",
      "Ongole",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS005",
    name: "Nellore",
    code: "NLR",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 30,
    facilities: ["Waiting Hall","Ticket Counter","Restrooms"],
    latitude: 14.4426,
    longitude: 79.9865,
    address: [
      "524003",
      "SPSR Nellore District",
      "Dargamitta",
      "Nellore",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS006",
    name: "Tirupati",
    code: "TPT",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 32,
    facilities: ["Waiting Hall","Food Court","Restrooms","Ticket Counter"],
    latitude: 13.6288,
    longitude: 79.4192,
    address: [
      "517501",
      "Tirupati District",
      "Railway Station Road",
      "Tirupati",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS007",
    name: "Kadapa",
    code: "CDP",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 24,
    facilities: ["Waiting Hall","Restrooms","Drinking Water"],
    latitude: 14.4673,
    longitude: 78.8242,
    address: [
      "516001",
      "YSR Kadapa District",
      "Seven Roads Junction",
      "Kadapa",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS008",
    name: "Anantapur",
    code: "ATP",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 26,
    facilities: ["Waiting Hall","Food Stalls","Restrooms"],
    latitude: 14.6819,
    longitude: 77.6006,
    address: [
      "515001",
      "Anantapur District",
      "Tower Clock Area",
      "Anantapur",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS009",
    name: "Kurnool",
    code: "KNL",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 30,
    facilities: ["Waiting Hall","Food Court","Restrooms"],
    latitude: 15.8281,
    longitude: 78.0373,
    address: [
      "518003",
      "Kurnool District",
      "Ballary Road",
      "Kurnool",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS010",
    name: "Rajahmundry",
    code: "RJY",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 29,
    facilities: ["Waiting Hall","Food Court","Restrooms"],
    latitude: 17.0005,
    longitude: 81.8040,
    address: [
      "533103",
      "East Godavari District",
      "Morampudi Junction",
      "Rajahmundry",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS011",
    name: "Kakinada",
    code: "KKD",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 20,
    facilities: ["Waiting Hall","Restrooms","Drinking Water"],
    latitude: 16.9891,
    longitude: 82.2475,
    address: [
      "533001",
      "Kakinada District",
      "Jagannaickpur",
      "Kakinada",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS012",
    name: "Eluru",
    code: "ELR",
    hubType: Hub.local,
    isDistrictHQ: true,
    platfroms: 18,
    facilities: ["Shelter","Drinking Water"],
    latitude: 16.7107,
    longitude: 81.0952,
    address: [
      "534002",
      "Eluru District",
      "Powerpet",
      "Eluru",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS013",
    name: "Chittoor",
    code: "CTR",
    hubType: Hub.local,
    isDistrictHQ: true,
    platfroms: 15,
    facilities: ["Shelter","Restrooms"],
    latitude: 13.2172,
    longitude: 79.1003,
    address: [
      "517001",
      "Chittoor District",
      "Greamspet",
      "Chittoor",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS014",
    name: "Vizianagaram",
    code: "VZM",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 22,
    facilities: ["Waiting Hall","Food Stalls"],
    latitude: 18.1133,
    longitude: 83.3956,
    address: [
      "535003",
      "Vizianagaram District",
      "RTC Colony",
      "Vizianagaram",
      "Andhra Pradesh"
    ],
  ),

  BusStop(
    id: "BS015",
    name: "Srikakulam",
    code: "SKM",
    hubType: Hub.major,
    isDistrictHQ: true,
    platfroms: 19,
    facilities: ["Waiting Hall","Restrooms"],
    latitude: 18.2969,
    longitude: 83.8970,
    address: [
      "532001",
      "Srikakulam District",
      "Arasavalli Road",
      "Srikakulam",
      "Andhra Pradesh"
    ],
  ),

];