part of "../pages/home_page.dart";

Widget IconAndInfo(IconData icon, String text) {
  return Builder(builder: (context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        //   color: Colors.yellow.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          Text(text)
        ],
      ),
    );
  });
}
