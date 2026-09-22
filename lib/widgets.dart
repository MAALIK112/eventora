import 'package:flutter/material.dart';
import 'apis.dart';
import 'styles.dart';

class EventoraImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BorderRadius? radius;
  final BoxFit fit;

  const EventoraImage(
      {super.key,
      required this.url,
      this.height,
      this.width,
      this.radius,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: Image.network(
        url,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (_, __, ___) => Container(
          height: height,
          width: width,
          color: EventoraStyles.blueSoft,
          child: const Icon(Icons.image_outlined, color: EventoraStyles.blue),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  const SearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) => TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search services, venues, vendors...',
          hintStyle: const TextStyle(color: EventoraStyles.muted, fontSize: 13),
          prefixIcon:
              const Icon(Icons.search_rounded, color: EventoraStyles.blue),
          suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.tune_rounded, color: EventoraStyles.ink)),
          filled: true,
          fillColor: EventoraStyles.surface,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
        ),
      );
}

class CategoryTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const CategoryTile(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
                color: EventoraStyles.blueSoft,
                borderRadius: BorderRadius.circular(18)),
            child: Icon(icon, color: EventoraStyles.blue, size: 25),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: EventoraStyles.ink)),
        ]),
      );
}

class ServiceCard extends StatelessWidget {
  final EventService service;
  final VoidCallback onTap;
  const ServiceCard({super.key, required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 220,
          decoration: EventoraStyles.card(),
          clipBehavior: Clip.antiAlias,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(children: [
              EventoraImage(url: service.image, height: 140, width: 220),
              Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .9),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.favorite_border_rounded,
                        size: 18, color: EventoraStyles.ink),
                  )),
            ]),
            Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 13),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: EventoraStyles.ink)),
                      const SizedBox(height: 4),
                      Text(service.type,
                          style: const TextStyle(
                              fontSize: 12, color: EventoraStyles.muted)),
                      const SizedBox(height: 9),
                      Row(children: [
                        const Icon(Icons.star_rounded,
                            size: 16, color: EventoraStyles.orange),
                        const SizedBox(width: 3),
                        Text('${service.rating}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12)),
                        const Spacer(),
                        Text('from \$${service.price}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: EventoraStyles.blue,
                                fontSize: 12)),
                      ]),
                    ])),
          ]),
        ),
      );
}

class BookingTile extends StatelessWidget {
  final Booking booking;
  final VoidCallback onTap;
  const BookingTile({super.key, required this.booking, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(12),
          decoration: EventoraStyles.card(),
          child: Row(children: [
            EventoraImage(
                url: booking.image,
                height: 72,
                width: 72,
                radius: BorderRadius.circular(14)),
            const SizedBox(width: 13),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(booking.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: EventoraStyles.ink)),
                  const SizedBox(height: 7),
                  Text(booking.date,
                      style: const TextStyle(
                          fontSize: 12, color: EventoraStyles.muted)),
                  const SizedBox(height: 8),
                  Text(booking.status,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: booking.status == 'Confirmed'
                              ? Colors.green
                              : EventoraStyles.orange)),
                ])),
            const Icon(Icons.chevron_right_rounded,
                color: EventoraStyles.muted),
          ]),
        ),
      );
}
