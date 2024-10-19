import 'package:diapets_mobile/components/diapets_icon_button/diapets_icon_button.dart';
import 'package:diapets_mobile/components/max_width_container/max_width_container.dart';
import 'package:diapets_mobile/components/page_nav_bar/page_nav_bar.dart';
import 'package:diapets_mobile/components/system_ui_customization.dart';
import 'package:diapets_mobile/pages/insulin_log_screen/insulin_log_content.dart';
import 'package:flutter/material.dart';

import 'filters_modal.dart';

class InsulinLogScreen extends StatelessWidget {
  const InsulinLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxWidthContainer(
      child: Scaffold(
        body: SystemUiCustomization(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Column(
                children: [
                  PageNavbar(
                    title: "Histórico",
                    actions: [
                      DiapetsIconButton(
                        icon: const Icon(
                          Icons.tune,
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const FiltersModal();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const InsulinLogContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
