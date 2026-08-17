import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String emoji;

  const DestinationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue,
            child: Text(
              emoji,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),


          const SizedBox(width: 15),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                const SizedBox(height: 5),


                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

              ],
            ),
          ),


          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.blue,
          ),

        ],
      ),
    );
  }
}