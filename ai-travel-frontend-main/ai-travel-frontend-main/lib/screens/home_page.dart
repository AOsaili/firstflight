import 'package:flutter/material.dart';
import 'trip_planner_page.dart';
import 'destination_details_page.dart';
import 'map_page.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // =========================================
              // HERO SECTION
              // =========================================

              Padding(
                padding: const EdgeInsets.all(16),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),

                  child: Stack(
                    children: [

                      // Background Image
                      Image.asset(
                        "assets/images/jordan.png",
                        height: 390,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      // Dark Gradient
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black87,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Top AI Badge
                      Positioned(
                        top: 20,
                        left: 20,

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: const Row(
                            children: [

                              Icon(
                                Icons.auto_awesome,
                                color: Colors.blue,
                                size: 18,
                              ),

                              SizedBox(width: 6),

                              Text(
                                "AI Powered Travel",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Hero Text
                      Positioned(
                        left: 22,
                        right: 22,
                        bottom: 25,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "AI Travel ✈️",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              "Discover Jordan,\n"
                              "your way.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                height: 1.15,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              "Let AI create a personalized journey "
                              "based on your time, style and budget.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Create Trip Button
                            SizedBox(
                              width: double.infinity,

                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TripPlannerPage(),
                                    ),
                                  );
                                },

                                icon: const Icon(
                                  Icons.auto_awesome,
                                  size: 20,
                                ),

                                label: const Text(
                                  "Create My AI Trip",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,

                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15),
                                  ),

                                  elevation: 0,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Explore Map Button
                            SizedBox(
                              width: double.infinity,

                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MapPage(),
                                    ),
                                  );
                                },

                                icon: const Icon(
                                  Icons.map,
                                  size: 20,
                                  color: Colors.white,
                                ),

                                label: const Text(
                                  "Explore Map",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),

                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.white,
                                  ),

                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // =========================================
              // QUICK INTRO
              // =========================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.explore,
                      color: Colors.blue,
                      size: 25,
                    ),

                    const SizedBox(width: 10),

                    const Expanded(
                      child: Text(
                        "Your next adventure starts here.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =========================================
              // POPULAR DESTINATIONS
              // =========================================

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),

                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Popular Destinations",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Explore the best of Jordan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Petra
              destinationCard(
                  context,
                title: "Petra",
                subtitle: "The ancient city carved in stone",
                image: "assets/images/petra.jpg",
                icon: "🏛️",
              ),

              // Wadi Rum
              destinationCard(
                context,
                title: "Wadi Rum",
                subtitle: "Adventure through the red desert",
                image: "assets/images/wadiRum.jpg",
                icon: "🏜️",
              ),

              // Aqaba
              destinationCard(
                context,
                title: "Aqaba",
                subtitle: "Relax by the Red Sea",
                image: "assets/images/aqaba.jpg",
                icon: "🌊",
              ),

              // Ajloun
              destinationCard(
                context,
                title: "Ajloun",
                subtitle: "Nature, forests and history",
                image: "assets/images/ajloun.jpg",
                icon: "🏰",
              ),

              const SizedBox(height: 30),

              // =========================================
              // FOOTER
              // =========================================

              Padding(
                padding: const EdgeInsets.only(
                  bottom: 25,
                ),

                child: Text(
                  "Made with AI for exploring Jordan 🇯🇴",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================
  // DESTINATION CARD
  // =========================================
Widget destinationCard(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String image,
  required String icon,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationDetailsPage(
            title: title,
            subtitle: subtitle,
            image: image,
            icon: icon,
          ),
        ),
      );
    },

    child: Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),

      height: 145,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),

        child: Row(
          children: [

            // Image
            SizedBox(
              width: 145,
              height: double.infinity,

              child: Stack(
                children: [

                  Image.asset(
                    image,
                    width: 145,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    top: 8,
                    left: 8,

                    child: Container(
                      padding: const EdgeInsets.all(6),

                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),

                      child: Text(
                        icon,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Row(
                      children: [

                        Text(
                          "Explore",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(width: 4),

                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}