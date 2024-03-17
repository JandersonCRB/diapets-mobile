import 'package:diapets_mobile/components/page_nav_bar/page_nav_bar.dart';
import 'package:diapets_mobile/pages/register_insulin_screen/register_insulin_form.dart';
import 'package:flutter/material.dart';

class RegisterInsulinScreen extends StatelessWidget {
  const RegisterInsulinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Column(
              children: [
                PageNavbar(title: 'Novo registro'),
                SizedBox(height: 48),
                RegisterInsulinForm(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
