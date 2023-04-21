import 'package:flutter/material.dart';
import '../component/onboarding_page.dart';
class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          OnboardingPage(
            image: Image.asset("assets/Images/onboarding1.jpg"),
            title: "Welcome",
            description:
            "Welcome to NADIF. Here you will find all about recycling at one place.",
            noOfScreen: 5,
            onNextPressed: changeScreen,
            currentScreenNo: 0,
          ),
          OnboardingPage(
            image: Image.asset("assets/Images/onboarding2.jpg"),
            title: "Compactge des déchets",
            description:
            "Compactez vos recyclables aprés les avoir nettoyés",
            noOfScreen: 5,
            onNextPressed: changeScreen,
            currentScreenNo: 1,
          ),
          //lets add 3rd screen
          OnboardingPage(
            image: Image.asset("assets/Images/loca.png"),
            title: "Déposer vos déchets à vendre",
            description:
            "Localisez votre position et publiez une annonce concernant vos déchets. Il y aura un calendrier pour la collecte des déchets.",
            noOfScreen: 5,
            onNextPressed: changeScreen,
            currentScreenNo: 2,
          ),
          OnboardingPage(
            image: Image.asset("assets/Images/point.jpg"),
            title: "Gagner des point",
            description:
            "Pour chaque dépôt de déchets, vous gagnerez des points de ramassage.",
            noOfScreen: 5,
            onNextPressed: changeScreen,
            currentScreenNo: 3,
          ),
          OnboardingPage(
            image: Image.asset("assets/Images/echange.jpg"),
            title: "Echange des points",
            description:
            "Echangez vos Points contre des récompses sur notre Marketplace",
            noOfScreen: 5,
            onNextPressed: changeScreen,
            currentScreenNo: 4,
          ),
        ],
      ),
    );
  }

  //Lets write function to change next onboarding screen
  void changeScreen(int nextScreenNo) {
    controller.animateToPage(nextScreenNo,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}