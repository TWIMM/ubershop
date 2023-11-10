import 'package:flutter/material.dart';

class DashElement {
  final String id;
  final String title;
  final int total;

  DashElement({
    required this.id,
    required this.title,
    required this.total,
  });
}

List<DashElement> demoProducts = [
  DashElement(id: "en_cours", title: "Livraison en cours", total: 10),
  DashElement(id: "_termine", title: "Livraisons éffectuées", total: 10),
];
