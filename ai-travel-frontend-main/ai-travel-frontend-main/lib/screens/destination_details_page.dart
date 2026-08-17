
import 'package:flutter/material.dart';

class DestinationDetailsPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String icon;

  const DestinationDetailsPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.icon,
  });

  // =========================
  // DESTINATION INFORMATION
  // =========================

  Map<String, String> _getDestinationInfo() {
  if (title == "Petra") {
    return {
      "description":
          "Explore the ancient Nabataean city carved into rose-red mountains and discover one of Jordan's most iconic landmarks.",
      "tip":
          "Visit Petra early in the morning to enjoy cooler weather and fewer crowds.",
      "bestTime":
          "Spring & Autumn",
    };
  }

  if (title == "Wadi Rum") {
    return {
      "description":
          "Experience the breathtaking red desert, dramatic mountains and unforgettable Bedouin culture in the Valley of the Moon.",
      "tip":
          "For the best experience, plan a sunset desert tour and spend a night under the stars.",
      "bestTime":
          "Spring & Autumn",
    };
  }

  if (title == "Aqaba") {
    return {
      "description":
          "Relax on the Red Sea coast and enjoy beautiful beaches, clear waters, coral reefs and exciting water activities.",
      "tip":
          "Try snorkeling or a glass-bottom boat trip to explore the Red Sea marine life.",
      "bestTime":
          "Autumn & Winter",
    };
  }

  return {
    "description":
        "Discover the green landscapes of northern Jordan, explore Ajloun Castle and enjoy peaceful mountain and forest views.",
    "tip":
        "Spring is a beautiful time to visit Ajloun when the forests and surrounding hills are especially green.",
    "bestTime":
        "Spring",
  };
}

  @override
  Widget build(BuildContext context) {
    final info = _getDestinationInfo();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // DESTINATION IMAGE
            // =========================

            Stack(
              children: [

                Image.asset(
                  image,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  left: 20,
                  bottom: 20,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Row(
                      children: [

                        Text(
                          icon,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // =========================
            // CONTENT
            // =========================

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // Subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // WHY VISIT
                  // =========================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Why Visit?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          info["description"]!,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
// =========================
// BEST TIME TO VISIT
// =========================

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(18),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),

    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  ),

  child: Row(
    children: [
      Container(
        width: 45,
        height: 45,

        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(14),
        ),

        child: const Icon(
          Icons.calendar_month,
          color: Colors.blue,
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Best Time to Visit",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              info["bestTime"]!,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            const Text(
              "Enjoy a more comfortable travel experience.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

const SizedBox(height: 25),

// =========================
// AI TIP
// =========================
                  // =========================
                  // AI TIP
                  // =========================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius:
                          BorderRadius.circular(18),

                      border: Border.all(
                        color: Colors.blue.shade100,
                      ),
                    ),

                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Container(
                          width: 45,
                          height: 45,

                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(14),
                          ),

                          child: const Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              const Text(
                                "AI Travel Tip",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                info["tip"]!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // =========================
                  // PLAN BUTTON
                  // =========================

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.auto_awesome,
                      ),

                      label: const Text(
                        "Plan My Trip",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 16,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),

                        elevation: 0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

