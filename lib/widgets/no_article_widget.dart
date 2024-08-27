import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoArticleWidget extends StatelessWidget {
  final ThemeData themeData;

  const NoArticleWidget({
    super.key,
    required this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: height * 0.15,
                color: themeData.iconTheme.color,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                'No Article Found',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 24,
                    color: themeData.textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              Text(
                'Try using another keyword',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: themeData.textTheme.displaySmall?.color,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
