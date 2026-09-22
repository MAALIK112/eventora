import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'apis.dart';
import 'styles.dart';
import 'widgets.dart';

class EventoraLogo extends StatelessWidget {
  final double size;

  const EventoraLogo({super.key, this.size = 42});

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        'assets/icons/eventora_mark.svg',
        width: size,
        height: size,
      );
}

class EventoraShell extends StatefulWidget {
  const EventoraShell({super.key});
  @override
  State<EventoraShell> createState() => _EventoraShellState();
}

class _EventoraShellState extends State<EventoraShell> {
  int index = 0;
  final pages = const [HomePage(), BookingsPage(), WalletPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) => setState(() => index = value),
          backgroundColor: EventoraStyles.surface,
          indicatorColor: EventoraStyles.blueSoft,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month_rounded),
                label: 'Bookings'),
            NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet_rounded),
                label: 'Wallet'),
            NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Profile'),
          ],
        ),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final services = EventoraApi.featuredServices();
  String query = '';

  @override
  Widget build(BuildContext context) {
    final visible = services
        .where((service) => '${service.name} ${service.type}'
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    return SafeArea(
        child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            children: [
          Row(children: [
            const EventoraLogo(size: 46),
            const SizedBox(width: 12),
            const Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Good morning,',
                      style:
                          TextStyle(color: EventoraStyles.muted, fontSize: 12)),
                  SizedBox(height: 3),
                  Text('Amina Wanjiku 👋',
                      style: TextStyle(
                          color: EventoraStyles.ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w800)),
                ])),
            IconButton(
                onPressed: () => _showNotifications(context),
                icon: const Icon(Icons.notifications_none_rounded,
                    color: EventoraStyles.ink)),
          ]),
          const SizedBox(height: 25),
          Text('Make your event',
              style: Theme.of(context).textTheme.headlineMedium),
          const Text('unforgettable.',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: EventoraStyles.blue)),
          const SizedBox(height: 18),
          SearchField(onChanged: (value) => setState(() => query = value)),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: EventoraStyles.navy,
                borderRadius: BorderRadius.circular(22)),
            child: Row(children: [
              const Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('Plan it. Book it.\nLove every moment.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            height: 1.25,
                            fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Everything your event needs, in one place.',
                        style:
                            TextStyle(color: Color(0xB8FFFFFF), fontSize: 12)),
                  ])),
              Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                      color: EventoraStyles.orange,
                      borderRadius: BorderRadius.circular(22)),
                  child: const Icon(Icons.auto_awesome_rounded,
                      color: Colors.white, size: 38)),
            ]),
          ),
          const SizedBox(height: 27),
          _sectionTitle(context, 'Explore categories', 'View all'),
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CategoryTile(
                label: 'Venues',
                icon: Icons.location_city_rounded,
                onTap: () {}),
            CategoryTile(
                label: 'Catering',
                icon: Icons.restaurant_rounded,
                onTap: () {}),
            CategoryTile(
                label: 'Photography',
                icon: Icons.camera_alt_rounded,
                onTap: () {}),
            CategoryTile(
                label: 'Decor',
                icon: Icons.local_florist_rounded,
                onTap: () {}),
          ]),
          const SizedBox(height: 28),
          _sectionTitle(context, 'Popular near you', 'See all'),
          const SizedBox(height: 15),
          SizedBox(
              height: 268,
              child: visible.isEmpty
                  ? const Center(
                      child: Text('No services found',
                          style: TextStyle(color: EventoraStyles.muted)))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: visible.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (_, i) => ServiceCard(
                          service: visible[i],
                          onTap: () => _showService(context, visible[i])))),
          const SizedBox(height: 25),
          _sectionTitle(context, 'Why Eventora?', ''),
          const SizedBox(height: 13),
          Row(children: const [
            Expanded(
                child: _Benefit(
                    icon: Icons.verified_rounded,
                    title: 'Trusted vendors',
                    text: 'Verified professionals')),
            SizedBox(width: 12),
            Expanded(
                child: _Benefit(
                    icon: Icons.payments_rounded,
                    title: 'Secure payments',
                    text: 'Book with confidence')),
          ]),
        ]));
  }

  Widget _sectionTitle(BuildContext context, String title, String action) =>
      Row(children: [
        Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
        if (action.isNotEmpty)
          Text(action,
              style: const TextStyle(
                  color: EventoraStyles.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
      ]);
}

class _Benefit extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _Benefit({required this.icon, required this.title, required this.text});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(14),
      decoration: EventoraStyles.card(),
      child: Row(children: [
        Icon(icon, color: EventoraStyles.blue, size: 25),
        const SizedBox(width: 9),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: EventoraStyles.ink)),
          const SizedBox(height: 3),
          Text(text,
              style:
                  const TextStyle(fontSize: 10, color: EventoraStyles.muted)),
        ])),
      ]));
}

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(
          child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              children: [
            Text('My bookings',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 6),
            const Text('Keep track of your upcoming experiences.',
                style: TextStyle(color: EventoraStyles.muted)),
            const SizedBox(height: 23),
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: EventoraStyles.blueSoft,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9)),
                          child: const Center(
                              child: Text('Upcoming',
                                  style: TextStyle(
                                      color: EventoraStyles.blue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12))))),
                  const Expanded(
                      child: Center(
                          child: Text('Past',
                              style: TextStyle(
                                  color: EventoraStyles.muted,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)))),
                ])),
            const SizedBox(height: 20),
            ...EventoraApi.bookings().map((booking) => BookingTile(
                booking: booking, onTap: () => _showBooking(context, booking))),
          ]));
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(
          child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              children: [
            Text('Wallet', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 6),
            const Text('Manage your Eventora payments.',
                style: TextStyle(color: EventoraStyles.muted)),
            const SizedBox(height: 25),
            Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [EventoraStyles.navy, EventoraStyles.blue]),
                    borderRadius: BorderRadius.circular(22)),
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AVAILABLE BALANCE',
                          style: TextStyle(
                              color: Color(0xB8FFFFFF),
                              fontSize: 11,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 10),
                      Text('\$1,240.00',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800)),
                      SizedBox(height: 22),
                      Text('••••  2849',
                          style:
                              TextStyle(color: Colors.white, letterSpacing: 2)),
                    ])),
            const SizedBox(height: 25),
            Text('Quick actions',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 14),
            Row(children: [
              _WalletAction(
                  icon: Icons.add_rounded, label: 'Add funds', onTap: () {}),
              const SizedBox(width: 12),
              _WalletAction(
                  icon: Icons.send_rounded, label: 'Transfer', onTap: () {}),
              const SizedBox(width: 12),
              _WalletAction(
                  icon: Icons.receipt_long_rounded,
                  label: 'History',
                  onTap: () {}),
            ]),
            const SizedBox(height: 27),
            Text('Recent transactions',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            const _Transaction(
                title: 'Booking payment',
                date: 'Today, 10:42 AM',
                amount: '- \$850.00',
                icon: Icons.calendar_month_rounded),
            const _Transaction(
                title: 'Wallet top up',
                date: '18 Aug 2024',
                amount: '+ \$1,000.00',
                icon: Icons.add_card_rounded,
                positive: true),
            const _Transaction(
                title: 'Booking payment',
                date: '12 Aug 2024',
                amount: '- \$240.00',
                icon: Icons.calendar_month_rounded),
          ]));
}

class _WalletAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _WalletAction(
      {required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) => Expanded(
      child: GestureDetector(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: EventoraStyles.card(),
              child: Column(children: [
                Icon(icon, color: EventoraStyles.blue),
                const SizedBox(height: 7),
                Text(label,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: EventoraStyles.ink))
              ]))));
}

class _Transaction extends StatelessWidget {
  final String title, date, amount;
  final IconData icon;
  final bool positive;
  const _Transaction(
      {required this.title,
      required this.date,
      required this.amount,
      required this.icon,
      this.positive = false});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE9ECF3)))),
      child: Row(children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: EventoraStyles.blueSoft,
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: EventoraStyles.blue, size: 19)),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: EventoraStyles.ink,
                  fontSize: 13)),
          const SizedBox(height: 3),
          Text(date,
              style: const TextStyle(color: EventoraStyles.muted, fontSize: 11))
        ])),
        Text(amount,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: positive ? Colors.green : EventoraStyles.ink,
                fontSize: 13)),
      ]));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(
          child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              children: [
            Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 23),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: EventoraStyles.card(),
                child: Row(children: [
                  const CircleAvatar(
                      radius: 34,
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/160?img=47')),
                  const SizedBox(width: 15),
                  const Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Amina Wanjiku',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: EventoraStyles.ink)),
                        SizedBox(height: 4),
                        Text('amina@example.com',
                            style: TextStyle(
                                color: EventoraStyles.muted, fontSize: 12))
                      ])),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined,
                          color: EventoraStyles.blue)),
                ])),
            const SizedBox(height: 24),
            const Text('Account',
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: EventoraStyles.ink)),
            const SizedBox(height: 9),
            _ProfileItem(
                icon: Icons.person_outline_rounded,
                title: 'Personal information'),
            _ProfileItem(
                icon: Icons.notifications_none_rounded, title: 'Notifications'),
            _ProfileItem(
                icon: Icons.help_outline_rounded, title: 'Help & support'),
            _ProfileItem(icon: Icons.settings_outlined, title: 'Settings'),
            const SizedBox(height: 18),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                label: const Text('Log out',
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.w700))),
          ]));
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const _ProfileItem({required this.icon, required this.title});
  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(top: 9),
      decoration: EventoraStyles.card(),
      child: ListTile(
          leading: Icon(icon, color: EventoraStyles.blue),
          title: Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: EventoraStyles.ink)),
          trailing: const Icon(Icons.chevron_right_rounded,
              color: EventoraStyles.muted)));
}

void _showNotifications(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (_) => const _Sheet(
        title: 'Notifications',
        child: Text(
            'You are all caught up! New booking updates will appear here.',
            style: TextStyle(color: EventoraStyles.muted))));
void _showService(BuildContext context, EventService service) =>
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => _Sheet(
            title: service.name,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              EventoraImage(
                  url: service.image,
                  height: 180,
                  width: double.infinity,
                  radius: BorderRadius.circular(16)),
              const SizedBox(height: 16),
              Text(service.type,
                  style: const TextStyle(color: EventoraStyles.muted)),
              const SizedBox(height: 8),
              Text('${service.location}  •  ★ ${service.rating}',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 18),
              SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Continue to booking')))
            ])));
void _showBooking(BuildContext context, Booking booking) =>
    showModalBottomSheet(
        context: context,
        builder: (_) => _Sheet(
            title: booking.name,
            child: Text('${booking.date}\n\nStatus: ${booking.status}',
                style: const TextStyle(
                    height: 1.6, color: EventoraStyles.muted))));

class _Sheet extends StatelessWidget {
  final String title;
  final Widget child;
  const _Sheet({required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9DDE8),
                        borderRadius: BorderRadius.circular(4)))),
            const SizedBox(height: 20),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            child
          ]));
}
