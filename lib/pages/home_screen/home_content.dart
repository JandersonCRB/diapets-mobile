import 'package:diapets_mobile/pages/home_screen/home_card.dart';
import 'package:diapets_mobile/pages/home_screen/home_controller.dart';
import 'package:diapets_mobile/services/date_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Obx(() {
      if (homeController.loading.value) {
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return const Column(
          children: [
            NextInsulinCard(),
            SizedBox(height: 24),
            LastInsulinCard(),
          ],
        );
      }
    });
  }
}

class NextInsulinCard extends StatelessWidget {
  const NextInsulinCard({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return HomeCard(
      child: Obx(
        () => Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homeController.onTime.value
                      ? "Próxima insulina"
                      : "Insulina em atraso",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: homeController.onTime.value
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  homeController.timeLeft.value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: homeController.onTime.value
                        ? const Color(0xFFFCFCFC)
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  homeController.onTime.value
                      ? "Agora é só aguardar!"
                      : "Verifique seus registros",
                  style: const TextStyle(
                    color: Color(0xFF888D92),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 110,
              child: Image.asset(
                homeController.onTime.value
                    ? "assets/images/time_fly.png"
                    : "assets/images/time_fly_red.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LastInsulinCard extends StatelessWidget {
  const LastInsulinCard({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    TextStyle textStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF888D92),
    );

    return HomeCard(
      child: Row(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Última insulina",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "${homeController.lastInsulinApplication.value?.insulinUnits.toString() ?? ''} unidades | ${homeController.lastInsulinApplication.value?.glucoseLevel.toString() ?? ''} glicose",
                  style: textStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  "Aplicador: ${homeController.lastInsulinApplication.value?.user?.firstName ?? ''}",
                  style: textStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  homeController
                              .lastInsulinApplication.value?.applicationTime !=
                          null
                      ? DateService.humanReadableDateTime(
                          homeController
                              .lastInsulinApplication.value!.applicationTime!,
                        )
                      : 'dd/mm às hh:mm',
                  style: textStyle,
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 110,
            child: Image.asset("assets/images/calendar_insulin.png"),
          ),
        ],
      ),
    );
  }
}
