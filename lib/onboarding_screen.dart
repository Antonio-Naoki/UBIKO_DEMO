import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:myapp/core/config/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:myapp/main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        // PÁGINA 1
        PageViewModel(
          titleWidget: const SizedBox.shrink(),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.asset(
                  'assets/images/onboarding_image_1.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "BIENVENIDO A UBIKO",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: const [
                    TextSpan(text: "Vamos a acercarte\nMas "),
                    TextSpan(
                      text: "Tu hogar ideal",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: const PageDecoration(
            pageColor: Colors.white,
            bodyAlignment: Alignment.center,
          ),
        ),

        // PÁGINA 2
        PageViewModel(
          titleWidget: const SizedBox.shrink(),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.asset(
                  'assets/images/onboarding_image.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Encuentra propiedades a tu manera",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Personaliza tu búsqueda con filtros detallados: desde el número de habitaciones y baños hasta el precio y las comodidades.",
                style:
                    GoogleFonts.roboto(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          decoration: const PageDecoration(
            pageColor: Colors.white,
            bodyAlignment: Alignment.center,
          ),
        ),

        // PÁGINA 3
        PageViewModel(
          titleWidget: const SizedBox.shrink(),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.asset(
                  'assets/images/onboarding_image.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Conéctate con el experto correcto",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Habla directamente con agentes inmobiliarios, solicita visitas y consigue respuestas a tus preguntas. Nuestro equipo de profesionales está aquí para guiarte en cada paso.",
                style:
                    GoogleFonts.roboto(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          decoration: const PageDecoration(
            pageColor: Colors.white,
            bodyAlignment: Alignment.center,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: Text(
        'Saltar',
        style: TextStyle(
          color: AppColors.textOnboardingPage, // 👈 usando tu clase de colores
        ),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: AppColors.textOnboardingPage, // 👈 también la flecha
      ),
      done: Text(
        'Hecho',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textOnboardingPage, // 👈 usando tu clase de colores
        ),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: AppColors.textOnboardingPage,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
