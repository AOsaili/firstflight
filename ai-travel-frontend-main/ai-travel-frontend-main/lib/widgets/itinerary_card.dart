import 'package:flutter/material.dart';

class ItineraryCard extends StatelessWidget {
  final String day;
  final String image;
  final List places;
  final String rating;
final String tripType;
  const ItineraryCard({
    super.key,
    required this.day,
    required this.image,
    required this.places,
    required this.rating,
  required this.tripType,
  });
String _getRecommendation() {
  final place = places.first.toString();

  if (place.contains("Wadi Rum")) {
    return "Best experienced at sunset with a desert tour and a night under the stars.";
  }

  if (place.contains("Petra")) {
    return "Start early to explore Petra comfortably and avoid the busiest hours.";
  }

  if (place.contains("Aqaba")) {
    return "Perfect for snorkeling, relaxing by the Red Sea and enjoying water activities.";
  }

  if (place.contains("Dana")) {
    return "A great choice for hiking, nature and discovering Jordan's beautiful landscapes.";
  }

  if (place.contains("Wadi Mujib")) {
    return "Ideal for adventure lovers looking for hiking and an exciting outdoor experience.";
  }

  if (place.contains("Dead Sea")) {
    return "Take time to relax by the water and enjoy the unique Dead Sea experience.";
  }

  if (place.contains("Jerash")) {
    return "Explore the ancient Roman ruins and discover Jordan's fascinating history.";
  }

  if (place.contains("Ajloun")) {
    return "Enjoy the green landscapes, forests and historic Ajloun Castle.";
  }

  if (place.contains("Amman Citadel")) {
    return "Visit the historic site and enjoy one of the best views over Amman.";
  }

  if (place.contains("Little Petra")) {
    return "Explore this fascinating Nabataean site and enjoy a quieter historical experience.";
  }

  return "A great place to include in your personalized Jordan itinerary.";
}
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // =========================================
            // IMAGE SECTION
            // =========================================

            SizedBox(
              height: 205,
              width: double.infinity,

              child: Stack(
                children: [

                  // Image
                  Image.asset(
                    image,
                    height: 205,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),

                  // Gradient
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black54,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Day Badge
                  Positioned(
                    top: 14,
                    left: 14,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Text(
                        day,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Rating
                  Positioned(
                    top: 14,
                    right: 14,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Row(
                        children: [

                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 18,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            rating,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Image Text
                  Positioned(
                    left: 16,
                    bottom: 14,

                    child: Text(
                      "Explore Jordan 🇯🇴",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =========================================
            // CONTENT
            // =========================================

            Padding(
              padding: const EdgeInsets.all(17),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Places to Visit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Places
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,

                    children: places.map(
                      (place) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),

                          child: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [

                              const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: 17,
                              ),

                              const SizedBox(width: 5),

                              Text(
                                place.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),

                  const SizedBox(height: 16),
// AI Recommendation
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(14),

  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(
      color: Colors.blue.shade100,
    ),
  ),

  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      Container(
        width: 36,
        height: 36,

        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),

        child: const Icon(
          Icons.auto_awesome,
          color: Colors.white,
          size: 19,
        ),
      ),

      const SizedBox(width: 10),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "AI Recommendation",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              _getRecommendation(),
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

const SizedBox(height: 16),
                  // Divider
                  Divider(
                    color: Colors.grey.shade200,
                    height: 1,
                  ),

                  const SizedBox(height: 14),

                  // Bottom Row
                  Row(
                    children: [

                      const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 20,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        "Jordan",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        "Explore",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(width: 4),

                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                        size: 17,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}