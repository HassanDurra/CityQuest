// import 'package:flutter/material.dart';

// class EventsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Events'),
//       ),
//       body: Center(
//         child: Text(
//           'Welcome to Events Page !',
//           style: TextStyle(fontSize: 24.0),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String imagePath;
  final String eventName;
  final String eventTime;
  final String eventDate;
  final String eventDescription;

  const EventCard({
    required this.imagePath,
    required this.eventName,
    required this.eventTime,
    required this.eventDate,
    required this.eventDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              eventName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$eventTime, $eventDate',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              eventDescription,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EventCard(
              imagePath: 'assets/images/artexhibition',
              eventName: 'art exhibition Event',
              eventTime: '10:00 AM',
              eventDate: 'April 17, 2024', 
              eventDescription: 'Description of Event 1', 
            ),
            
            SizedBox(height: 20.0),
            EventCard(
              imagePath: 'assets/images/cultrual',
              eventName: 'cultrual  Event',
              eventTime: '2:00 PM',
              eventDate: 'April 18, 2024',
              eventDescription: 'Description of Event 2',
            ),
          ],
        ),
      ),
    );
  }
}