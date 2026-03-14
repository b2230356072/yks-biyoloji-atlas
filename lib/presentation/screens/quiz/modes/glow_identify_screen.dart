import '../../../../core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../widgets/interactive/glowing_region.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';
import 'dart:ui';

// --- YOUR PROVIDED WIDGETS & FUNCTIONS GO HERE ---
// (GlowingRegion, _GlowingRegionState, and extractIsolatedShape)

// Helper to dim the background shapes
String getDimmedBackground(String rawSvg) {
  final document = XmlDocument.parse(rawSvg);
  final allElements =
      document.findAllElements('*').where((e) => e.getAttribute('id') != null);
  for (var element in allElements) {
    element.setAttribute('fill-opacity', '1.0');
    element.removeAttribute('stroke');
  }
  return document.toXmlString();
}

class GlowIdentifyScreen extends StatefulWidget {
  const GlowIdentifyScreen({super.key});

  @override
  State<GlowIdentifyScreen> createState() => _GlowIdentifyScreenState();
}

class _GlowIdentifyScreenState extends State<GlowIdentifyScreen> {
  // 1. Quiz State Variables
  final String targetId = "outer_2"; // The part that will glow!
  String? selectedAnswerId; // Tracks what the user tapped
  bool hasAnswered = false;

  // Mock MCQ Data
  final List<Map<String, String>> options = [
    {"letter": "A", "text": "Golgi Cisimciği", "id": "outer_1"},
    {"letter": "B", "text": "Ribozom", "id": "outer_2"},
    {"letter": "C", "text": "Hücre Çekirdeği", "id": "inner_2"}, // Correct!
    {"letter": "D", "text": "Mitokondri", "id": "inner_1"},
  ];

  @override
  Widget build(BuildContext context) {
    String hexString =
        '#${(AppColors.glowColor.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

    return Scaffold(
      backgroundColor: Color(0xFFF2EBD9), // Dark background from your demo
      body: SafeArea(
        child: Column(
          children: [
            // --- TOP APP BAR ---
            Container(
              // 1. Keep your exact same padding
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

              // 2. Add the white background and the subtle bottom border from your CSS demo
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFD8CFBA), // Your --border color
                    width: 1.0,
                  ),
                ),
              ),

              // 3. Keep your exact same Row and children
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 24,
                    height:
                        24, // Forces the button to stay exactly the size of the icon
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close,
                            color: Colors.grey, size: 24),
                        hoverColor: Colors.grey.shade200,
                        splashRadius: 18, // Keeps the hover circle tight

                        // THIS is the magic line that stops it from expanding!
                        style: IconButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => {Navigator.pop(context)}
                        // Navigator.pop(context);
                        ),
                  ),
                  // this is going to be implemented
                  const Text(
                    "7 / 12",
                    style: TextStyle(
                      color: Color(0xFF7A9452),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: const [
                      // this will also be implemented
                      Icon(Icons.timer_outlined, color: Colors.grey, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "0:58",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // --- PROGRESS BAR ---
            Container(
              height: 4,
              width: double.infinity,
              color: const Color(0xFF2A2A2A),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.58, // 58% complete
                child: Container(color: const Color(0xFF4E6035)),
              ),
            ),

            // --- MODE LABEL ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.auto_awesome, color: Color(0xFF2980B9), size: 18),
                  SizedBox(width: 8),
                  Text("Parlayanı Bil",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // --- SVG CANVAS ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFEEF4E0),
                    Color(0xFFDDE8C4)
                  ], // Cream/Green gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: FutureBuilder<String>(
                future: rootBundle.loadString("assets/images/dummy.svg"),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  String rawSvg = snapshot.data!;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // 1. Background
                      SvgPicture.string(getDimmedBackground(rawSvg),
                          height: 160),

                      // 2. The Pulsing Faded Glow
                      GlowingRegion(
                        glowing: true,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: SvgPicture.string(
                            extractIsolatedShape(
                                rawSvg, targetId, hexString, "10"),
                            height: 160,
                          ),
                        ),
                      ),

                      // 3. The Solid Border
                      SvgPicture.string(
                        extractIsolatedShape(rawSvg, targetId, hexString, "1"),
                        height: 160,
                      ),
                    ],
                  );
                },
              ),
            ),

            // --- HINT TEXT ---
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Bu yapının adı nedir?",
                style: TextStyle(color: AppColors.textHint, fontSize: 14),
              ),
            ),

            // --- MULTIPLE CHOICE OPTIONS ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isCorrect = option["id"] == targetId;
                  final isSelected = selectedAnswerId == option["id"];

                  // Determine colors based on selection
                  Color bgColor = Colors.white;
                  Color borderColor = const Color(0xFFD8CFBA);
                  Color letterBgColor = const Color(0xFFE5D9C0);
                  Color textColor = AppColors.textPrimary;

                  if (hasAnswered) {
                    if (isCorrect) {
                      bgColor =
                          AppColors.successLight; // Light green background
                      borderColor = AppColors.primaryDark; // Green border
                      letterBgColor = AppColors.primaryDark;
                      textColor = AppColors.textPrimary; // Make letter white
                    } else if (isSelected && !isCorrect) {
                      bgColor = AppColors.errorLight; // Light red
                      borderColor = AppColors.error; // Red border
                      letterBgColor = AppColors.error;
                      textColor = Colors.white;
                    }
                  }

                  return GestureDetector(
                    onTap: () {
                      if (!hasAnswered) {
                        setState(() {
                          selectedAnswerId = option["id"];
                          hasAnswered = true; // Lock in the answer
                        });
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      child: Row(
                        children: [
                          // Letter Circle (A, B, C, D)
                          Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: letterBgColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              option["letter"]!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      hasAnswered && (isCorrect || isSelected)
                                          ? Colors.white
                                          : AppColors.textPrimary),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Answer Text
                          Text(
                            option["text"]!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2A2A2A),
                            ),
                          ),
                          const Spacer(),
                          // Checkmark or X icon
                          if (hasAnswered && isCorrect)
                            const Icon(Icons.check,
                                color: Color(0xFF4E6035), size: 20),
                          if (hasAnswered && isSelected && !isCorrect)
                            const Icon(Icons.close,
                                color: Color(0xFFC0392B), size: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
