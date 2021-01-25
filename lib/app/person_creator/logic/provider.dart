import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final personCreatorNameController = Provider<TextEditingController>((ref) => TextEditingController());
final personDescriptionController = Provider<TextEditingController>((ref) => TextEditingController());
final personImportance = StateProvider<int>((ref) => 0);
final personCategory = StateProvider<String>((ref) => "");
final personLocation = StateProvider<String>((ref) => "");
final isWaitingCreation = StateProvider<bool>((ref) => false);