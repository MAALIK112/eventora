import 'dart:async';

class ServicesApi {
  final List<Map<String, dynamic>> _mockServices = [
    {
      'id': 's1',
      'name': 'Premium Wedding Planning',
      'category': 'Event Planning',
      'description': 'End-to-end premium wedding planning services including venue, catering, and decor.',
      'price': 5000.0,
      'rating': 4.9,
      'imageUrl': 'https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's2',
      'name': 'Corporate Conference Package',
      'category': 'Corporate',
      'description': 'Full service conference planning for up to 500 attendees.',
      'price': 3500.0,
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's3',
      'name': 'Grand Ballroom Venue',
      'category': 'Venue Booking',
      'description': 'Luxurious ballroom suitable for weddings and galas.',
      'price': 2500.0,
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's4',
      'name': 'Professional Security Team',
      'category': 'Security',
      'description': 'Trained security personnel for private and public events.',
      'price': 800.0,
      'rating': 4.5,
      'imageUrl': 'https://images.unsplash.com/photo-1552664730-d307ca884978?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's5',
      'name': 'Elite Waitstaff',
      'category': 'Staff Hiring',
      'description': 'Professional waitstaff for high-end dining experiences.',
      'price': 400.0,
      'rating': 4.6,
      'imageUrl': 'https://images.unsplash.com/photo-1559339352-11d035aa65de?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's6',
      'name': 'Live Band Entertainment',
      'category': 'Private Parties',
      'description': 'Top tier live band playing covers of classic hits.',
      'price': 1200.0,
      'rating': 4.9,
      'imageUrl': 'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's7',
      'name': 'Welcome Reception Setup',
      'category': 'Reception',
      'description': 'Beautiful setup for greeting guests with drinks and appetizers.',
      'price': 600.0,
      'rating': 4.4,
      'imageUrl': 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's8',
      'name': 'Beachfront Venue Booking',
      'category': 'Venue Booking',
      'description': 'Scenic beachfront venue for outdoor events.',
      'price': 1500.0,
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's9',
      'name': 'Photography & Videography',
      'category': 'Weddings',
      'description': 'Capture your special moments with our expert team.',
      'price': 2000.0,
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=900&q=80',
    },
    {
      'id': 's10',
      'name': 'DJ & Sound System',
      'category': 'Private Parties',
      'description': 'Professional DJ setup for an unforgettable night.',
      'price': 700.0,
      'rating': 4.6,
      'imageUrl': 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&w=900&q=80',
    },
  ];

  Future<List<Map<String, dynamic>>> getServices({String? category, String? search}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    var results = _mockServices;
    if (category != null && category.isNotEmpty) {
      results = results.where((s) => s['category'] == category).toList();
    }
    if (search != null && search.isNotEmpty) {
      results = results.where((s) => s['name'].toLowerCase().contains(search.toLowerCase())).toList();
    }
    return results;
  }

  Future<Map<String, dynamic>> getServiceById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockServices.firstWhere((s) => s['id'] == id, orElse: () => throw Exception('Service not found'));
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      {'id': 'c1', 'name': 'Event Planning'},
      {'id': 'c2', 'name': 'Venue Booking'},
      {'id': 'c3', 'name': 'Staff Hiring'},
      {'id': 'c4', 'name': 'Security'},
      {'id': 'c5', 'name': 'Reception'},
      {'id': 'c6', 'name': 'Corporate'},
      {'id': 'c7', 'name': 'Weddings'},
      {'id': 'c8', 'name': 'Private Parties'},
      {'id': 'c9', 'name': 'Conferences'},
    ];
  }

  Future<List<Map<String, dynamic>>> searchServices(String query) async {
    return getServices(search: query);
  }
}
