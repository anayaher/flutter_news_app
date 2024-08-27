import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news/models/article.dart';
import 'package:news/screens/article_screen.dart';
import 'package:skeletons/skeletons.dart';

class NewsCard extends StatefulWidget {
  final ThemeData themeData;
  final Article article;

  const NewsCard({
    super.key,
    required this.article,
    required this.themeData,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    final theme = widget.themeData;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleScreen(
              article: widget.article,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 4, // Increased elevation for shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          color: theme.cardColor, // Use theme's card color
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8), // Rounded corners for image
                  child: Image.network(
                    widget.article.urlToImage.toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                    frameBuilder: (BuildContext context, Widget child,
                        int? frame, bool wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      if (frame == null) {
                        return Center(
                          child: Skeleton(
                            isLoading: true,
                            skeleton: SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                lines: 1,
                                spacing: 6,
                                lineStyle: SkeletonLineStyle(
                                  height: 150,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: const SizedBox.shrink(),
                          ),
                        );
                      }
                      return child;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.article.title.toString(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: theme.textTheme.bodyLarge?.color ??
                            Colors.black87, // Use theme text color
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color:
                                  theme.iconTheme.color, // Use theme icon color
                              size: 20,
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                widget.article.author.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: theme.textTheme.bodyLarge?.color ??
                                        Colors.black54, // Use theme text color
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color:
                                theme.iconTheme.color, // Use theme icon color
                            size: 20,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            Jiffy.parse(widget.article.publishedAt.toString())
                                .fromNow()
                                .toString(),
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: theme.textTheme.bodyMedium?.color ??
                                    Colors.black54, // Use theme text color
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.article.description.toString(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: theme.textTheme.bodyMedium?.color ??
                            Colors.black87, // Use theme text color
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
