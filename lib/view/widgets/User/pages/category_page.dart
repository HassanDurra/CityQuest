import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ThingsToDoPage(),
    EventsPage(),
    FoodAndDrinksPage(),
    RestaurantsPage(),
    SeasPage(),
    ParksPage(),
  ]; // List of pages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: _pages[_selectedIndex], // Displaying selected page content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Function to handle tab selection
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Things To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Food & Drinks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.beach_access),
            label: 'Seas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.park),
            label: 'Parks',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    // Update selected tab index
    setState(() {
      _selectedIndex = index;
    });
  }
}
//////thing to do 
class ThingsToDoCard extends StatelessWidget {
  final String imagePath;
  final String thingName;
  final String history;
  final int reviewsCount;

  const ThingsToDoCard({
    required this.imagePath,
    required this.thingName,
    required this.history,
    required this.reviewsCount,
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
              thingName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              history,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '$reviewsCount Reviews',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(width: 10), 
                Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.amber, 
                ),
                SizedBox(width: 5),
                Text(
                  'Open',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ThingsToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Things To Do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ThingsToDoCard(
              imagePath: 'assets/images/historica.jpg',
              thingName: 'Historical Sites',
              history: 'Learn about the rich history of our city.',
              reviewsCount: 5,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/museum.jpg',
              thingName: 'Museums',
              history: 'Explore fascinating exhibits from around the world.',
              reviewsCount: 8,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/shopping.webp',
              thingName: 'Shopping Centers',
              history: 'Shop till you drop at our city\'s diverse shopping centers.',
              reviewsCount: 10,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/sports.jpg',
              thingName: 'Sports Facilities',
              history: 'Stay active and enjoy various sports activities at our state-of-the-art facilities.',
              reviewsCount: 6,
            ),
          ],
        ),
      ),
    );
  }
}
/////evvent 
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
              imagePath: 'assets/images/artexhibition.jpg',
              eventName: 'Art Exhibition Event',
              eventTime: '10:00 AM',
              eventDate: 'April 17, 2024', 
              eventDescription: 'Description of Event 1', 
            ),
            SizedBox(height: 20.0),
            EventCard(
              imagePath: 'assets/images/cultrual.jpg',
              eventName: 'Cultural Event',
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



////food and drink
class FoodAndDrinksCard extends StatelessWidget {
  final String imagePath;
  final String itemName;
  final String description;
  final int reviewsCount;

  const FoodAndDrinksCard({
    required this.imagePath,
    required this.itemName,
    required this.description,
    required this.reviewsCount,
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
              itemName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '$reviewsCount Reviews',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(width: 10), 
                Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.amber, 
                ),
                SizedBox(width: 5),
                Text(
                  'Open',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FoodAndDrinksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food & Drinks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FoodAndDrinksCard(
              imagePath: 'assets/images/indian_restaurant.jpg',
              itemName: 'Indian Restaurant',
              description: 'Explore the flavors of India with our authentic dishes.',
              reviewsCount: 1200,
            ),
            SizedBox(height: 20.0),
            FoodAndDrinksCard(
              imagePath: 'assets/images/italian_restaurant.jpg',
              itemName: 'Italian Restaurant',
              description: 'Experience the taste of Italy with our delicious pizzas and pastas.',
              reviewsCount: 1500,
            ),
            SizedBox(height: 20.0),
            FoodAndDrinksCard(
              imagePath: 'assets/images/chinese_restaurant.jpg',
              itemName: 'Chinese Restaurant',
              description: 'Savor the flavors of China with our wide variety of dishes.',
              reviewsCount: 1800,
            ),
            SizedBox(height: 20.0),
            FoodAndDrinksCard(
              imagePath: 'assets/images/thai_restaurant.jpg',
              itemName: 'Thai Restaurant',
              description: 'Indulge in the spicy and aromatic dishes of Thailand.',
              reviewsCount: 1300,
            ),
            SizedBox(height: 20.0),
            FoodAndDrinksCard(
              imagePath: 'assets/images/sports_bar.jpg',
              itemName: 'Sports Bar',
              description: 'Enjoy live sports matches and a wide selection of drinks in a vibrant atmosphere.',
              reviewsCount: 900,
            ),
           
            SizedBox(height: 20.0),
            FoodAndDrinksCard(
              imagePath: 'assets/images/cocktail_bar.jpg',
              itemName: 'Cocktail Bar',
              description: 'Experience the art of mixology with our expertly crafted cocktails.',
              reviewsCount: 850,
            ),
          
          ],
        ),
      ),
    );
  }
}








////restaruent
class RestaurantCard extends StatelessWidget {
  final String imagePath;
  final String restaurantName;
  final String description;
  final int reviewsCount;

  const RestaurantCard({
    required this.imagePath,
    required this.restaurantName,
    required this.description,
    required this.reviewsCount,
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
              restaurantName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '$reviewsCount Reviews',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(width: 10), 
                Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.amber, 
                ),
                SizedBox(width: 5),
                Text(
                  'Open',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RestaurantCard(
              imagePath: 'assets/images/clocktower.jpg',
              restaurantName: 'Clock Tower',
              description: 'Description of Restaurant 1.',
              reviewsCount: 3000,
            ),
            SizedBox(height: 20.0),
            RestaurantCard(
              imagePath: 'assets/images/kolachi.jpg',
              restaurantName: 'Kolachi',
              description: 'Description of Restaurant 2.',
              reviewsCount: 90000,
            ),
            SizedBox(height: 20.0),
            RestaurantCard(
              imagePath: 'assets/images/coconutgrove.jpeg',
              restaurantName: 'Coconut Grove',
              description: 'Description of Restaurant 3.',
              reviewsCount: 1097,
            ),
          ],
        ),
      ),
    );
  }
}
////////seas 
class SeasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ThingsToDoCard(
              imagePath: 'assets/images/atlanticocean.jpg',
              thingName: 'Atlantic Ocean',
              history: 'Atlantic Ocean, body of salt water covering approximately one-fifth of Earths surface and separating the continents of Europe and Africa to the east from those of North and South America to the west.',
              reviewsCount: 14345,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/IndianOcean.webp',
              thingName: 'Indian Ocean',
              history: 'Indian Ocean, body of salt water covering approximately one-fifth of the total ocean area of the world. ',
              reviewsCount: 257890,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/pacificocean.jpg',
              thingName: 'Pacific Ocean',
              history: 'The Pacific Ocean is the largest and deepest ocean basin on Earth, covering more than 155 million square kilometers (60 million square miles) and averaging a depth of 4,000 meters (13,000 feet).',
              reviewsCount: 132547,
            ),
          ],
        ),
      ),
    );
  }
}

class ParksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ThingsToDoCard(
              imagePath: 'assets/images/hillpark.jpg',
              thingName: 'Hill Park',
              history: 'Hill Park is situated on a hilltop surrounded by a residential area known as PECHS neighborhood of Jamshed Town in Karachi, Sindh, Pakistan',
              reviewsCount: 157698,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/iqbalpark.jpg',
              thingName: 'Iqbal Park',
              history: 'Iqbal Park formerly Minto Park, is an urban park. After renovation and expansion, it was named as Greater Iqbal Park. The 125-acre park includes an artificial lake which spreads over four acres which includes an 800 ft. long musical fountain..',
              reviewsCount: 21497,
            ),
            SizedBox(height: 20.0),
            ThingsToDoCard(
              imagePath: 'assets/images/safaripark.jpg',
              thingName: 'Safari Park',
              history: 'A safari park, sometimes known as a wildlife park, is a zoo-like commercial drive-in tourist attraction where visitors can drive their own vehicles or ride in vehicles provided by the facility to observe freely roaming animals.',
              reviewsCount: 107534,
            ),
          ],
        ),
      ),
    );
  }
}
