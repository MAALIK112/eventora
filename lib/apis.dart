import 'package:flutter/material.dart';

/// Frontend data source. Images use Unsplash's free source CDN and can be
/// replaced with a real backend without changing the page widgets.
class EventoraApi {
  static const _images = [
    'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=900&q=85',
    'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=900&q=85',
    'https://images.unsplash.com/photo-1519741497674-611481863552?w=900&q=85',
    'https://images.unsplash.com/photo-1478146896981-b80fe463b330?w=900&q=85',
    'https://images.unsplash.com/photo-1507504031003-b417219a0fde?w=900&q=85',
  ];

  static List<EventService> featuredServices() => [
        EventService('The Garden House', 'Elegant venue', 'Kampala, Uganda',
            4.9, 850, _images[0], Icons.location_city_rounded),
        EventService('Luna Moments', 'Wedding photography', 'Entebbe, Uganda',
            4.8, 620, _images[1], Icons.camera_alt_rounded),
        EventService('Saffron Table', 'Premium catering', 'Kampala, Uganda',
            4.7, 420, _images[2], Icons.restaurant_rounded),
        EventService('Bloom & Co.', 'Floral decoration', 'Jinja, Uganda', 4.9,
            280, _images[3], Icons.local_florist_rounded),
      ];

  static List<Booking> bookings() => [
        Booking('The Garden House', 'Saturday, 24 Aug 2024', 'Confirmed',
            _images[0]),
        Booking('Luna Moments', 'Sunday, 08 Sep 2024', 'Pending payment',
            _images[1]),
      ];
}

class EventService {
  final String name;
  final String type;
  final String location;
  final double rating;
  final int price;
  final String image;
  final IconData icon;

  const EventService(this.name, this.type, this.location, this.rating,
      this.price, this.image, this.icon);
}

class Booking {
  final String name;
  final String date;
  final String status;
  final String image;

  const Booking(this.name, this.date, this.status, this.image);
}
