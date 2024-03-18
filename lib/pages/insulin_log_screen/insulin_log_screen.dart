import 'package:diapets_mobile/components/page_nav_bar/page_nav_bar.dart';
import 'package:diapets_mobile/components/system_ui_customization.dart';
import 'package:diapets_mobile/pages/insulin_log_screen/insulin_log_content.dart';
import 'package:flutter/material.dart';

class InsulinLogScreen extends StatelessWidget {
  const InsulinLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SystemUiCustomization(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 24),
            child: Column(
              children: [
                PageNavbar(
                  title: "Histórico",
                ),
                SizedBox(height: 32),
                InsulinLogContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
