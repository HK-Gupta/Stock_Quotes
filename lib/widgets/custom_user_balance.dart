import 'package:flutter/material.dart';

import '../config/assets_path.dart';

class CustomUserBalance extends StatelessWidget {
  const CustomUserBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                ImagePaths.loginPic,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Balance",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.orange
                ),
              ),
              const SizedBox(height: 3,),
              Text(
                "₹ 50,143.23",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right,)
        ],
      ),
    );
  }
}
