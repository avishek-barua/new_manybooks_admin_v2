import 'package:flutter/material.dart';

import '../constants.dart';

class CloudStorageInfo {
  final String svgSrc, title, totalStorage;
  final int numOfFiles, percentage;
  final Color color;

  CloudStorageInfo({
    required this.svgSrc,
    required this.title,
    required this.color,
    required this.numOfFiles,
    required this.percentage,
    required this.totalStorage
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: 'Documents',
    numOfFiles: 1328,
    color: primaryColor,
    svgSrc: 'assets/icons/Documents.svg',
    totalStorage: '1.9GB',
    percentage: 35
  ),
  CloudStorageInfo(
    title: 'Google Drive',
    numOfFiles: 1328,
    color: Color(0xFFFFA113),
    svgSrc: 'assets/icons/google_drive.svg',
    totalStorage: '1.9GB',
    percentage: 35
  ),
  CloudStorageInfo(
    title: 'One Drive',
    numOfFiles: 1328,
    color: Color(0xFFA4CDFF),
    svgSrc: 'assets/icons/one_drive.svg',
    totalStorage: '1.9GB',
    percentage: 35
  ),
  CloudStorageInfo(
    title: 'Documents',
    numOfFiles: 1328,
    color: Color(0xFF007EE5),
    svgSrc: 'assets/icons/drop_box.svg',
    totalStorage: '1.9GB',
    percentage: 35
  )
];
