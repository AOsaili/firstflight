import 'dart:async';
import 'package:flutter/material.dart';
import 'trip_result_page.dart';
import '../services/api_service.dart';

class AILoadingPage extends StatefulWidget {
  final int days;
  final String tripType;
  final String budget;

  const AILoadingPage({
    super.key,
    required this.days,
    required this.tripType,
    required this.budget,
  });

  @override
  State<AILoadingPage> createState() => _AILoadingPageState();
}

class _AILoadingPageState extends State<AILoadingPage> {
  int currentStep = 0;

  final List<String> steps = [
    "Understanding your travel preferences",
    "Finding the best destinations",
    "Building your day-by-day itinerary",
    "Optimizing your trip for your budget",
  ];

  @override
  void initState() {
    super.initState();

    _startPlanning();
  }

  void _startPlanning() {
    Timer.periodic(
      const Duration(milliseconds: 900),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (currentStep < steps.length - 1) {
          setState(() {
            currentStep++;
          });
        } else {
          timer.cancel();
          _callTripPlannerApi();
        }
      },
    );
  }

  Future<void> _callTripPlannerApi() async {
    // Amman, Jordan — the app only covers Jordan trips right now.
    try {
      await ApiService.planTrip(
        userId: "guest",
        latitude: 31.9454,
        longitude: 35.9284,
        duration: "${widget.days} days",
        preferences: widget.tripType,
      );
    } catch (e) {
      debugPrint("Trip planner API call failed: $e");
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TripResultPage(
          days: widget.days,
          tripType: widget.tripType,
          budget: widget.budget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                // =====================================
                // AI ICON
                // =====================================

                Container(
                  width: 100,
                  height: 100,

                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.blue,
                    size: 48,
                  ),
                ),

                const SizedBox(height: 30),

                // =====================================
                // TITLE
                // =====================================

                const Text(
                  "Creating your trip ✨",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Our AI is designing a personalized "
                  "Jordan experience for you.",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 35),

                // =====================================
                // PROGRESS
                // =====================================

                LinearProgressIndicator(
                  minHeight: 7,

                  borderRadius: BorderRadius.circular(10),

                  backgroundColor: Colors.blue.shade50,

                  color: Colors.blue,

                  value:
                      (currentStep + 1) / steps.length,
                ),

                const SizedBox(height: 25),

                // =====================================
                // STEPS
                // =====================================

                Column(
                  children: List.generate(
                    steps.length,

                    (index) {
                      final bool completed =
                          index < currentStep;

                      final bool active =
                          index == currentStep;

                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 14,
                        ),

                        child: Row(
                          children: [

                            Container(
                              width: 28,
                              height: 28,

                              decoration: BoxDecoration(
                                color: completed || active
                                    ? Colors.blue
                                    : Colors.grey.shade300,

                                shape: BoxShape.circle,
                              ),

                              child: Icon(
                                completed
                                    ? Icons.check
                                    : active
                                        ? Icons.auto_awesome
                                        : Icons.circle,

                                color: Colors.white,

                                size: active
                                    ? 16
                                    : 15,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                steps[index],

                                style: TextStyle(
                                  fontSize: 14,

                                  fontWeight:
                                      active || completed
                                          ? FontWeight.w600
                                          : FontWeight.normal,

                                  color:
                                      active || completed
                                          ? Colors.black87
                                          : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // =====================================
                // TRIP SUMMARY
                // =====================================

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(15),
                  ),

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Text(
                        "${widget.days} Days",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Text("•"),

                      const SizedBox(width: 12),

                      Text(
                        widget.tripType,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Text("•"),

                      const SizedBox(width: 12),

                      Text(
                        widget.budget,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}