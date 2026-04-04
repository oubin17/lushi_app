import 'package:flutter/material.dart';
import 'package:lushi_app/features/home/presentation/widgets/private_resume_table_widget.dart';
import 'package:lushi_app/widgets/appbar/app_bar.dart';

class PrivateResumePage extends StatelessWidget {
  const PrivateResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(title: const Text('私有库')),
      body: const PrivateResumeTableWidget(),
    );
  }
}
