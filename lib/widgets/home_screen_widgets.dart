import 'package:docu_genie/models/document_model.dart';
import 'package:flutter/material.dart';

Widget buildFeaturedCard(BuildContext context, Document document,
    Function(Document) navigateToForm) {
  return GestureDetector(
    onTap: () => navigateToForm(document),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(document.imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              document.imagePath,
              fit: BoxFit.cover,
              width: 1000,
              height: 500,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.info_outline,
                  color: document.name == 'Legacy Policy'
                      ? Colors.white
                      : Colors.black,
                  size: 30,
                  fill: 0.9),
              tooltip: 'More Info',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[900]?.withOpacity(0.9),
                    title: Text(
                      document.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    content: Text(
                      document.description,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: 1000,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Text(
              document.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDocumentCard(BuildContext context, Document document,
    Function(Document) navigateToForm) {
  return GestureDetector(
    onTap: () => navigateToForm(document),
    child: Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF1D1E33).withOpacity(0.8),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(document.imagePath,
              width: 40, height: 40, fit: BoxFit.contain),
          const SizedBox(height: 8),
          Text(
            document.name,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
