import 'package:flutter/material.dart';
import '../widgets/itinerary_card.dart';
import '../data/jordan_destinations.dart';

class TripResultPage extends StatelessWidget {
  final int days;
  final String tripType;
  final String budget;

  const TripResultPage({
    super.key,
    required this.days,
    required this.tripType,
    required this.budget,
  });

  List<JordanDestination> _getDestinations() {
  if (tripType == "Adventure") {
    return adventureDestinations;
  } else if (tripType == "Family") {
    return familyDestinations;
  } else if (tripType == "Relax") {
    return relaxDestinations;
  } else {
    return historicalDestinations;
  }
}

String _getHeroImage() {
  if (tripType == "Adventure") {
    return "assets/images/wadiRum.jpg";
  } else if (tripType == "Family") {
    return "assets/images/aqaba.jpg";
  } else if (tripType == "Relax") {
    return "assets/images/jordan.png";
  } else {
    return "assets/images/petra.jpg";
  }
}

String _getHeroTitle() {
  if (tripType == "Adventure") {
    return "🏜️ Your Jordan Adventure";
  } else if (tripType == "Family") {
    return "👨‍👩‍👧 Your Jordan Family Trip";
  } else if (tripType == "Relax") {
    return "🌴 Your Relaxing Jordan Trip";
  } else {
    return "🏛️ Your Jordan Historical Journey";
  }
}
String _getRecommendation() {
  if (tripType == "Adventure") {
    return "Start your day early for outdoor adventures, then enjoy a sunset experience in Wadi Rum.";
  } else if (tripType == "Family") {
    return "Plan relaxed activities with enough breaks to make the journey comfortable and enjoyable for everyone.";
  } else if (tripType == "Relax") {
    return "Take your time and enjoy peaceful moments by the Dead Sea and the Red Sea.";
  } else {
    return "Start early to explore Jordan's historical sites comfortably and make the most of your day.";
  }
}
double _getEstimatedBudget() {
  double dailyCost;

  if (budget == "Low") {
    dailyCost = 35;
  } else if (budget == "Medium") {
    dailyCost = 70;
  } else {
    dailyCost = 120;
  }

  return dailyCost * days;
}
  @override
  Widget build(BuildContext context) {
    final destinations = _getDestinations();

    final int numberOfDays =
        days > destinations.length ? destinations.length : days;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
  backgroundColor: Colors.white,
  foregroundColor: Colors.black87,
  elevation: 0,

  centerTitle: false,

  title: Row(
    children: [
      Container(
        width: 38,
        height: 38,

        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Icon(
          Icons.flight_takeoff,
          color: Colors.blue.shade700,
          size: 21,
        ),
      ),

      const SizedBox(width: 10),

      const Text(
        "Your AI Jordan Trip",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ],
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // =====================================
              // HERO SECTION
              // =====================================

              ClipRRect(
                borderRadius: BorderRadius.circular(22),

                child: Stack(
                  children: [

                    Image.asset(
  _getHeroImage(),
  height: 240,
  width: double.infinity,
  fit: BoxFit.cover,
),

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

                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 20,

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                           _getHeroTitle(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            "AI-powered itinerary made just for you",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =====================================
              // AI TITLE
              // =====================================

              const Text(
                "🇯🇴 AI Generated Plan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Your personalized journey through Jordan",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),

              // =====================================
              // TRIP OVERVIEW
              // =====================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Trip Overview",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [

                        Expanded(
                          child: _InfoItem(
                            icon: Icons.calendar_month,
                            title: "Days",
                            value: "$days",
                          ),
                        ),

                        Expanded(
                          child: _InfoItem(
                            icon: Icons.backpack,
                            title: "Type",
                            value: tripType,
                          ),
                        ),

                        Expanded(
                          child: _InfoItem(
                            icon: Icons.account_balance_wallet,
                            title: "Budget",
                            value: budget,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =====================================
              // ITINERARY TITLE
              // =====================================

              const Text(
                "Your Personalized Itinerary",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Explore your day-by-day AI travel plan",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),

              // =====================================
              // ITINERARY
              // =====================================

              ...List.generate(
                numberOfDays,

                (index) {
                  final destination =
                      destinations[index];

                  final nextDestination =
                      destinations[
                        (index + 1) %
                            destinations.length
                      ];

                  final List<String> places = [
                    destination.name,
                    if (days > 1 &&
                        index < destinations.length - 1)
                      nextDestination.name,
                  ];

                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20),

                    child: ItineraryCard(
                      day: "Day ${index + 1}",
                      image: destination.image,
                      places: places,
                      rating: destination.rating,
                      tripType: tripType,
                    ),
                  );
                },
              ),
              // =====================================
// BUDGET SUMMARY
// =====================================

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),

    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      Row(
        children: [
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(15),
            ),

            child: Icon(
              Icons.account_balance_wallet,
              color: Colors.green.shade700,
              size: 25,
            ),
          ),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Budget Summary",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 3),

              Text(
  "$budget Budget • $days ${days == 1 ? "Day" : "Days"}",
  style: TextStyle(
    fontSize: 13,
    color: Colors.grey.shade600,
    fontWeight: FontWeight.w500,
  ),
),
            ],
          ),
        ],
      ),

      const SizedBox(height: 22),

      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [
            const Text(
              "Estimated Total",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            Text(
              "${_getEstimatedBudget().toStringAsFixed(0)} JD",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 18),
const Text(
  "Budget Distribution",
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _BudgetItem(
              icon: Icons.hotel,
              title: "Stay",
              value: "${(_getEstimatedBudget() * 0.40).toStringAsFixed(0)} JD",
            ),
          ),

          Expanded(
            child: _BudgetItem(
              icon: Icons.restaurant,
              title: "Food",
              value: "${(_getEstimatedBudget() * 0.25).toStringAsFixed(0)} JD",
            ),
          ),

          Expanded(
            child: _BudgetItem(
              icon: Icons.directions_car,
              title: "Transport",
              value: "${(_getEstimatedBudget() * 0.20).toStringAsFixed(0)} JD",
            ),
          ),

          Expanded(
            child: _BudgetItem(
              icon: Icons.local_activity,
              title: "Activities",
              value: "${(_getEstimatedBudget() * 0.15).toStringAsFixed(0)} JD",
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),

ClipRRect(
  borderRadius: BorderRadius.circular(10),

  child: Row(
    children: [
      Expanded(
        flex: 40,
        child: Container(
          height: 10,
          color: Colors.blue,
        ),
      ),

      Expanded(
        flex: 25,
        child: Container(
          height: 10,
          color: Colors.orange,
        ),
      ),

      Expanded(
        flex: 20,
        child: Container(
          height: 10,
          color: Colors.green,
        ),
      ),

      Expanded(
        flex: 15,
        child: Container(
          height: 10,
          color: Colors.purple,
        ),
      ),
    ],
  ),
),
    ],
  ),
),

const SizedBox(height: 24),
// =====================================
// AI RECOMMENDATION
// =====================================

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(18),

  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.blue.shade50,
        Colors.white,
      ],
    ),
    borderRadius: BorderRadius.circular(20),

    border: Border.all(
      color: Colors.blue.shade100,
    ),
  ),

  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      Container(
        width: 48,
        height: 48,

        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),

        child: const Icon(
          Icons.auto_awesome,
          color: Colors.white,
          size: 25,
        ),
      ),

      const SizedBox(width: 14),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "AI Recommendation",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 7),

            Text(

              _getRecommendation(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

const SizedBox(height: 20),

// =====================================
// BOOK BUTTON
// =====================================
              const SizedBox(height: 10),

              // =====================================
              // BOOK BUTTON
              // =====================================

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Trip booked successfully! 🎉",
                        ),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,

                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 17,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    elevation: 0,
                  ),

                  child: const Text(
                    "Book This Trip ✈️",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
}

// ======================================
// TRIP INFORMATION ITEM
// ======================================

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Icon(
          icon,
          color: Colors.blue,
          size: 26,
        ),

        const SizedBox(height: 7),

        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,

          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
    
  }
  
}class _BudgetItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _BudgetItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.green.shade700,
          size: 22,
        ),

        const SizedBox(height: 6),

        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}