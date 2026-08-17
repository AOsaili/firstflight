import 'package:flutter/material.dart';
//import 'trip_result_page.dart';
import 'ai_loading_page.dart';

class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({super.key});

  @override
  State<TripPlannerPage> createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  int days = 3;
  String tripType = "Adventure";
  String budget = "Medium";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "AI Trip Planner",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // =========================================
              // AI INTRO CARD
              // =========================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff1976D2),
                      Color(0xff42A5F5),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(22),
                ),

                child: const Row(
                  children: [

                    CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.white,

                      child: Icon(
                        Icons.auto_awesome,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            "Let's plan your trip ✨",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "Tell our AI what you want, "
                            "and we'll build your Jordan adventure.",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================================
              // DAYS
              // =========================================

              const Text(
                "How long is your trip?",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Choose the number of days you want to explore Jordan.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),

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
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.calendar_month,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Trip Duration",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [

                        IconButton(
                          onPressed: () {
                            if (days > 1) {
                              setState(() {
                                days--;
                              });
                            }
                          },

                          icon: const Icon(
                            Icons.remove_circle_outline,
                          ),

                          color: Colors.blue,
                        ),

                        Container(
                          width: 42,
                          height: 42,

                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),

                          child: Text(
                            "$days",
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            if (days < 14) {
                              setState(() {
                                days++;
                              });
                            }
                          },

                          icon: const Icon(
                            Icons.add_circle_outline,
                          ),

                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================================
              // TRIP TYPE
              // =========================================

              const Text(
                "What kind of trip do you want?",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Choose the experience that matches your mood.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 15),

              Wrap(
                spacing: 10,
                runSpacing: 10,

                children: [

                  _tripTypeCard(
                    title: "Adventure",
                    icon: "🏜️",
                  ),

                  _tripTypeCard(
                    title: "Family",
                    icon: "👨‍👩‍👧‍👦",
                  ),

                  _tripTypeCard(
                    title: "Relax",
                    icon: "🌴",
                  ),

                  _tripTypeCard(
                    title: "Historical",
                    icon: "🏛️",
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================================
              // BUDGET
              // =========================================

              const Text(
                "What's your budget?",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "We'll use your budget to personalize your plan.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 15),

              Wrap(
                spacing: 10,
                runSpacing: 10,

                children: [

                  _budgetCard(
                    title: "Low",
                    icon: "💰",
                  ),

                  _budgetCard(
                    title: "Medium",
                    icon: "💰💰",
                  ),

                  _budgetCard(
                    title: "Luxury",
                    icon: "💰💰💰",
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // =========================================
              // GENERATE BUTTON
              // =========================================

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: () {
                   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AILoadingPage(
      days: days,
      tripType: tripType,
      budget: budget,
    ),
  ),
);
                  },

                  icon: const Icon(
                    Icons.auto_awesome,
                  ),

                  label: const Text(
                    "Generate My AI Plan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,

                    padding: const EdgeInsets.symmetric(
                      vertical: 17,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    elevation: 0,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  "✨ Your personalized Jordan itinerary awaits",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================
  // TRIP TYPE CARD
  // =========================================

  Widget _tripTypeCard({
    required String title,
    required String icon,
  }) {
    final bool selected = tripType == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          tripType = title;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: selected
              ? Colors.blue
              : Colors.white,

          borderRadius: BorderRadius.circular(15),

          border: Border.all(
            color: selected
                ? Colors.blue
                : Colors.grey.shade300,
          ),

          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [

            Text(
              icon,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(width: 8),

            Text(
              title,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.black87,

                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================
  // BUDGET CARD
  // =========================================

  Widget _budgetCard({
    required String title,
    required String icon,
  }) {
    final bool selected = budget == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          budget = title;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 13,
        ),

        decoration: BoxDecoration(
          color: selected
              ? Colors.blue
              : Colors.white,

          borderRadius: BorderRadius.circular(15),

          border: Border.all(
            color: selected
                ? Colors.blue
                : Colors.grey.shade300,
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [

            Text(
              icon,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),

            const SizedBox(width: 8),

            Text(
              title,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.black87,

                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}