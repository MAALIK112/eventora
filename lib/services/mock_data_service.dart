import '../models/service_model.dart';
import '../models/review_model.dart';
import '../models/booking_model.dart';
import '../models/wallet_model.dart';
import '../models/support_model.dart';

class MockDataService {
  static List<EventService> getServices() {
    return [
      // 1. Photography - Aurelia Luxe
      const EventService(
        id: 'srv-photo-01',
        title: 'Aurelia Fine Art Cinematic Photography & Film',
        category: 'Photography',
        description:
            'Bespoke editorial wedding and gala visual storytelling. We capture transcendent, candid emotion with medium-format Leica optics, master lighting, and curated filmic post-production.',
        location: 'Beverly Hills & Global Destinations',
        startingPrice: 1850.0,
        rating: 4.98,
        reviewsCount: 142,
        isFeatured: true,
        isTopRated: true,
        images: [
          'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1511285560929-80b456fea0bc?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1532712938310-34cb3982ef74?auto=format&fit=crop&w=1200&q=80',
        ],
        highlights: [
          'Dual Master Lead Photographers',
          'Same-Day Editorial Teaser Reel',
          'Handmade Italian Leather Heirloom Album',
          'Licensed 4K Cinema Drone Footage',
        ],
        provider: ProviderInfo(
          id: 'prov-01',
          name: 'Elena Rostova',
          avatar:
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
          title: 'Master Visual Artist & Vogue Contributor',
          rating: 4.99,
          reviewsCount: 180,
          eventsCompleted: 320,
          responseTime: 'Within 15 mins',
          bio:
              '12+ years immortalizing luxury weddings, celebrity galas, and high-fashion soirees across 24 countries.',
          location: 'Los Angeles, CA',
        ),
        packages: [
          ServicePackage(
            id: 'pkg-photo-1',
            name: 'Essential Editorial',
            tier: 'Silver',
            price: 1850.0,
            duration: '6 Hours Coverage',
            description:
                'Comprehensive coverage for intimate milestone celebrations and boutique weddings.',
            features: [
              '1 Lead Fine-Art Photographer',
              '350+ Color-Graded High-Res Deliverables',
              'Online Private Gallery with 10-Year Cloud Archive',
              'Full Print Licensing & Rights',
            ],
          ),
          ServicePackage(
            id: 'pkg-photo-2',
            name: 'Grand Gala Celebration',
            tier: 'Gold',
            price: 3400.0,
            duration: '10 Hours Full Coverage',
            description:
                'Signature multi-angle storytelling with drone cinema and aerial vantage points.',
            features: [
              '2 Lead Photographers + Drone Pilot',
              '700+ Master Retouched Photographs',
              '4K 3-Minute Highlight Film Reel',
              '30-Page Flush Mount Leather Album (12x12)',
              'Priority 14-Day Delivery Guarantee',
            ],
            isPopular: true,
          ),
          ServicePackage(
            id: 'pkg-photo-3',
            name: 'Royal Heritage Ultra Luxe',
            tier: 'Platinum Luxe',
            price: 5900.0,
            duration: 'Multi-Day VIP Access',
            description:
                'The pinnacle of bespoke event luxury. Full weekend coverage including welcome cocktail and farewell brunch.',
            features: [
              '3 Principal Artists + Dedicated Editor On-Site',
              '1,200+ Masterpieces in Museum Velvet Finish',
              'Complete 20-Minute Cinematic Feature Film',
              'Twin Parent Albums + Custom Archival Linen Box',
              'Next-Morning 50-Image Press & Social Suite',
            ],
          ),
        ],
        availableAddons: [
          ServiceAddon(
              id: 'add-1',
              name: 'Vintage 35mm Analog Film Roll Service',
              price: 450.0,
              description:
                  '5 rolls of authentic Kodak Portra 400 processed by Richard Photo Lab'),
          ServiceAddon(
              id: 'add-2',
              name: 'Live Glamour Portrait Studio Booth',
              price: 850.0,
              description:
                  'Black-and-white vanity studio with immediate guest prints'),
          ServiceAddon(
              id: 'add-3',
              name: 'Luxury Drone 4K FPV Master Video',
              price: 600.0,
              description:
                  'Custom fly-through choreography of the entire venue and entrance'),
        ],
        reviews: [
          Review(
            id: 'rev-01',
            userName: 'Charlotte Sinclair-Vance',
            userAvatar:
                'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
            rating: 5.0,
            date: 'September 28, 2026',
            comment:
                'Elena and her crew captured our Napa Valley estate gala with an editorial magnificence that took our breath away. The lighting, warmth, and emotion feel straight out of Vogue.',
            eventType: 'Estate Wedding',
          ),
          Review(
            id: 'rev-02',
            userName: 'Alexander Wright',
            userAvatar:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
            rating: 4.9,
            date: 'August 14, 2026',
            comment:
                'Extremely professional, invisible during key moments yet always in the perfect spot. The drone footage of our sunset dinner exceeded every expectation.',
            eventType: '50th Anniversary Gala',
          ),
        ],
      ),

      // 2. Venues - The Grand Bel-Air Pavilion
      const EventService(
        id: 'srv-venue-02',
        title: 'The Grand Bel-Air Pavilion & Rose Glasshouse',
        category: 'Venues',
        description:
            'A historic Mediterranean villa with manicured French topiary gardens, a modern temperature-controlled crystal glasshouse, and panoramic canyon vistas.',
        location: 'Bel-Air, California',
        startingPrice: 4500.0,
        rating: 4.96,
        reviewsCount: 98,
        isFeatured: true,
        images: [
          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1545232979-fbf6c97a5a87?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?auto=format&fit=crop&w=1200&q=80',
        ],
        highlights: [
          'Up to 450 Seated Guests Capacity',
          'Private Bridal & VIP Executive Suites',
          'Curfew-Free Architectural Sound System',
          'Dedicated Valet & Security Detail Included',
        ],
        provider: ProviderInfo(
          id: 'prov-02',
          name: 'Julian Montgomery',
          avatar:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
          title: 'Estate Director & Senior Hospitality Curator',
          rating: 4.97,
          reviewsCount: 110,
          eventsCompleted: 215,
          responseTime: 'Within 30 mins',
          bio:
              'Curating world-class milestone receptions, charity balls, and high-profile private gatherings for over 15 years.',
          location: 'Bel-Air, CA',
        ),
        packages: [
          ServicePackage(
            id: 'pkg-ven-1',
            name: 'Sunset Terrace & Lawn',
            tier: 'Silver',
            price: 4500.0,
            duration: '8 Hours Event Window',
            description:
                'Access to the outdoor Italian fountain terrace and open lawns for cocktail and dining soirees.',
            features: [
              'Accommodates up to 150 guests',
              'Bespoke bistro lighting canopy',
              'Commercial prep kitchen for caterers',
              'Complimentary valet parking team (4 attendants)',
            ],
          ),
          ServicePackage(
            id: 'pkg-ven-2',
            name: 'Grand Glasshouse & Estate Grounds',
            tier: 'Gold',
            price: 8500.0,
            duration: '14 Hours (10am - 12am)',
            description:
                'Exclusive estate buyout including the illuminated Crystal Glasshouse and grand ballroom.',
            features: [
              'Accommodates up to 350 guests',
              'Full climate-controlled glass pavilion',
              'Private bridal suite & groom lounge with champagne bar',
              'State-of-the-art DMX ambient lighting & acoustics',
              'On-site facility manager and custodial crew throughout',
            ],
            isPopular: true,
          ),
          ServicePackage(
            id: 'pkg-ven-3',
            name: 'Weekend Royalty Buyout',
            tier: 'Platinum Luxe',
            price: 16000.0,
            duration: '48-Hour Exclusive Estate Lockout',
            description:
                'Complete non-stop access to the entire private villa grounds, suites, and gardens for 2 full days.',
            features: [
              'Up to 450 guests capacity',
              'Overnight VIP suite accommodation for 12 guests',
              'Helipad landing privileges & armed discreet security',
              'Rehearsal dinner, Gala, and Farewell Brunch included',
            ],
          ),
        ],
        availableAddons: [
          ServiceAddon(
              id: 'add-ven-1',
              name: 'Estate Fountain Fireworks & Pyro Display',
              price: 2200.0,
              description:
                  'Permitted low-smoke cold spark and aerial celebration display'),
          ServiceAddon(
              id: 'add-ven-2',
              name: 'Bespoke Chandelier Installation Suite',
              price: 1400.0,
              description:
                  '8 crystal cascading chandeliers rigged within the glasshouse'),
        ],
        reviews: [
          Review(
            id: 'rev-03',
            userName: 'Lady Genevieve Sterling',
            userAvatar:
                'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=200&q=80',
            rating: 5.0,
            date: 'September 12, 2026',
            comment:
                'The Crystal Glasshouse under a starlit Bel-Air sky was pure poetry. Our guests are still raving about the enchanting atmosphere and seamless hospitality.',
            eventType: 'Charity Gala',
          ),
        ],
      ),

      // 3. Catering - Maison De L'Or Gastronomie
      const EventService(
        id: 'srv-cat-03',
        title: 'Maison De L\'Or Michelin-Trained Culinary Arts',
        category: 'Catering',
        description:
            'Multi-course French-Mediterranean haute cuisine curated by Michelin-star alumni. Custom seasonal tasting menus paired with sommelier wine reserves.',
        location: 'San Francisco & Wine Country',
        startingPrice: 2200.0,
        rating: 4.97,
        reviewsCount: 164,
        isTopRated: true,
        images: [
          'https://images.unsplash.com/photo-1555244162-803834f70033?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80',
        ],
        highlights: [
          '100% Farm-to-Table Organic Sourcing',
          'Master Sommelier Wine & Champagne Pairing',
          'White-Glove Silver Service Staff',
          'Customized Molecular Gastronomy Stations',
        ],
        provider: ProviderInfo(
          id: 'prov-03',
          name: 'Chef Antoine Mercier',
          avatar:
              'https://images.unsplash.com/photo-1577219491135-ce391730fb2c?auto=format&fit=crop&w=400&q=80',
          title: 'Executive Chef & Culinary Director',
          rating: 4.98,
          reviewsCount: 220,
          eventsCompleted: 480,
          responseTime: 'Within 20 mins',
          bio:
              'Former sous-chef at Le Gabriel Paris. Dedicated to making every bite an unforgettable multisensory masterpiece.',
          location: 'San Francisco, CA',
        ),
        packages: [
          ServicePackage(
            id: 'pkg-cat-1',
            name: 'Canapés & Craft Cocktail Salon',
            tier: 'Silver',
            price: 2200.0,
            duration: '3 Hours Interactive Cocktail Hour',
            description:
                '10 luxury passed hors d\'oeuvres, oyster shucking bar, and 3 bespoke cocktail infusions for up to 60 guests.',
            features: [
              'Fresh Brittany Oysters with Champagne Mignonette',
              'Truffled Wagyu Beef Tartare Crisps',
              'Artisanal Mixologist Bar Service',
              'Porcelain & Crystal Glassware Included',
            ],
          ),
          ServicePackage(
            id: 'pkg-cat-2',
            name: 'Five-Course Grand Epicurean Dinner',
            tier: 'Gold',
            price: 4800.0,
            duration: 'Full Evening Plated Service',
            description:
                'Plated 5-course banquet with prime choices of Chilean Seabass, Miyazaki A5 Wagyu, and Grand Cru dessert.',
            features: [
              'Complete 5-course customized plated tasting menu',
              'Sommelier curated wine pairing for each course',
              'Handmade artisanal bread & churned cultured butter',
              'White-glove tuxedo waitstaff (1 server per 8 guests)',
            ],
            isPopular: true,
          ),
          ServicePackage(
            id: 'pkg-cat-3',
            name: 'Royal Imperial Gastronomy & Caviar Bar',
            tier: 'Platinum Luxe',
            price: 8900.0,
            duration: 'Full Gala Multi-Station & Midnight Feast',
            description:
                'Petrossian Caviar ice sculpture station, live truffle carving, and 7-course culinary journey.',
            features: [
              'Imperial Oscietra Caviar service with blinis and frozen vodka',
              'A5 Kagoshima Wagyu carving presentation table',
              'Dessert soufflé station & molecular dessert theatrics',
              'Late-night French crêperie cart with gourmet fillings',
            ],
          ),
        ],
        availableAddons: [
          ServiceAddon(
              id: 'add-cat-1',
              name: 'Vintage Champagne Tower Experience',
              price: 950.0,
              description:
                  '6-tier crystal coupe tower filled with Dom Pérignon / Krug'),
          ServiceAddon(
              id: 'add-cat-2',
              name: 'Master Cheese & Charcuterie Grotto Table',
              price: 750.0,
              description:
                  'Aged French Comté, Jamón Ibérico de Bellota, and honeycomb'),
        ],
        reviews: [
          Review(
            id: 'rev-04',
            userName: 'Marcus Sterling',
            userAvatar:
                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
            rating: 5.0,
            date: 'October 1, 2026',
            comment:
                'Chef Antoine created a culinary symphony. The Wagyu melted in your mouth, and the caviar station was the undisputed star of our banquet.',
            eventType: 'Corporate Gala',
          ),
        ],
      ),

      // 4. Event Planning - Haute Couture Events
      const EventService(
        id: 'srv-plan-04',
        title: 'Haute Couture Bespoke Event Planning & Production',
        category: 'Event Planning',
        description:
            'Full-spectrum architectural event design, vendor curation, logistics orchestration, and day-of command for high-net-worth gatherings.',
        location: 'New York & Global',
        startingPrice: 3500.0,
        rating: 4.99,
        reviewsCount: 210,
        isFeatured: true,
        images: [
          'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=1200&q=80',
        ],
        highlights: [
          'Complete 3D Venue Visualization & Renderings',
          'Unrestricted Vendor Negotiation & Contract Audits',
          'Concierge Guest RSVP & VIP Hospitality Desk',
          '24/7 Dedicated Lead Producer Support',
        ],
        provider: ProviderInfo(
          id: 'prov-04',
          name: 'Vivienne St. Claire',
          avatar:
              'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=400&q=80',
          title: 'Founder & Principal Creative Producer',
          rating: 4.99,
          reviewsCount: 230,
          eventsCompleted: 350,
          responseTime: 'Immediate',
          bio:
              'Named Top Event Producer by Harper’s Bazaar. Translating ambitious creative dreams into effortless, impeccably timed reality.',
          location: 'Manhattan, NY',
        ),
        packages: [
          ServicePackage(
            id: 'pkg-plan-1',
            name: 'Month-of Master Coordination',
            tier: 'Silver',
            price: 3500.0,
            duration: '6 Weeks Prior + Event Day',
            description:
                'Seamless handover and timeline execution for clients who have already selected primary vendors.',
            features: [
              'Timeline drafting & vendor load-in orchestration',
              'Rehearsal direction & ceremony coordination',
              '2 Senior Coordinators on-site for 12 hours',
              'Emergency luxury toolkit & guest escorting',
            ],
          ),
          ServicePackage(
            id: 'pkg-plan-2',
            name: 'Comprehensive Design & Production',
            tier: 'Gold',
            price: 7500.0,
            duration: '6-12 Months Planning Cycle',
            description:
                'From initial moodboards and budget architecture to custom staging, menu curation, and complete production.',
            features: [
              'Full creative concept, mood boards & 3D floral renderings',
              'Vendor sourcing, pricing audits & contract locks',
              'Full design of stationery, tablescapes, lighting & sound',
              '4 Dedicated Producers on event day from dawn to pack-down',
            ],
            isPopular: true,
          ),
        ],
        availableAddons: [
          ServiceAddon(
              id: 'add-plan-1',
              name: 'VIP Guest Travel & Chauffeur Logistics',
              price: 1800.0,
              description:
                  'Airport transfers, private charter coordination, and hotel welcome gifting'),
        ],
        reviews: [],
      ),

      // 5. Decorations & Florals - Fleur Royale
      const EventService(
        id: 'srv-dec-05',
        title: 'Fleur Royale Botanical Sculptures & Luxe Decor',
        category: 'Decorations',
        description:
            'Extravagant floral installations, hanging botanical arches, custom mirrored dining tables, and bespoke crystal candelabras.',
        location: 'Miami & Palm Beach',
        startingPrice: 2800.0,
        rating: 4.95,
        reviewsCount: 118,
        images: [
          'https://images.unsplash.com/photo-1526047932273-341f2a7631f9?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1469371670807-013ccf25f16a?auto=format&fit=crop&w=1200&q=80',
        ],
        highlights: [
          'Imported Dutch & Ecuadorian Long-Stem Roses',
          'Suspended Floral Clouds & Grand Stage Arches',
          'Handmade Velvet Draping & Custom Linens',
        ],
        provider: ProviderInfo(
          id: 'prov-05',
          name: 'Mateo De Silva',
          avatar:
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80',
          title: 'Master Botanical Architect',
          rating: 4.95,
          reviewsCount: 120,
          eventsCompleted: 290,
          responseTime: 'Within 1 hour',
          bio:
              'Celebrated floral sculptor creating immersive floral worlds for luxury galas and milestone festivities.',
          location: 'Miami, FL',
        ),
        packages: [
          ServicePackage(
            id: 'pkg-dec-1',
            name: 'Botanical Harmony Suite',
            tier: 'Silver',
            price: 2800.0,
            duration: 'Complete Floral Dressing',
            description:
                '10 High & Low botanical tablescapes, entrance floral arch, and ambient votive illumination.',
            features: [
              '10 Grand floral centerpieces with seasonal blooms',
              'Grand cascading floral welcome arch',
              'Fragrant garden rose & eucalyptus arrangements',
              'Delivery, installation, and late-night breakdown',
            ],
          ),
        ],
        availableAddons: [],
        reviews: [],
      ),

      // 6. Entertainment - Symphony & Neon String Quartet
      const EventService(
        id: 'srv-ent-06',
        title: 'Aura Electric Symphony & Live DJ Collective',
        category: 'Entertainment',
        description:
            'A fusion of classical virtuoso violinists and modern deep house DJ performers. High-energy live music tailored for unforgettable entrances.',
        location: 'Chicago, IL & Nationwide',
        startingPrice: 1950.0,
        rating: 4.97,
        reviewsCount: 88,
        images: [
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=1200&q=80',
        ],
        highlights: [
          'LED Illuminated Carbon Fiber Violins',
          'Hybrid Live Brass, Saxophone & DJ Set',
          'Custom Arranged Entrance Songs',
        ],
        provider: ProviderInfo(
          id: 'prov-06',
          name: 'Sebastian Vance',
          avatar:
              'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=400&q=80',
          title: 'Music Director & Composer',
          rating: 4.98,
          reviewsCount: 95,
          eventsCompleted: 180,
          responseTime: 'Within 2 hours',
          bio:
              'Juilliard graduate blending classical orchestral precision with festival-level audio production.',
          location: 'Chicago, IL',
        ),
        packages: [
          ServicePackage(
            id: 'pkg-ent-1',
            name: 'Cocktail & Ceremony String Quartet',
            tier: 'Silver',
            price: 1950.0,
            duration: '3 Hours Performance',
            description:
                'Acoustic or electric string quartet playing classical favorites and Bridgerton-style pop covers.',
            features: [
              '4 Virtuoso musicians in formal black-tie attire',
              'Custom arrangement of 3 client-selected songs',
              'Full PA system and wireless microphone support',
            ],
          ),
        ],
        availableAddons: [],
        reviews: [],
      ),
    ];
  }

  static List<Booking> getInitialBookings() {
    final services = getServices();
    return [
      Booking(
        id: 'EVT-2026-8841',
        service: services[0], // Aurelia Photography
        selectedPackage: services[0].packages[1], // Gold
        selectedAddons: [services[0].availableAddons[0]],
        eventDate: DateTime(2026, 11, 20),
        eventTime: '15:00 - 23:00',
        eventLocation: 'Rosewood Estate, Santa Barbara, CA',
        eventType: 'Wedding & Gala',
        guestCount: 180,
        specialRequests:
            'Sunset drone shoot at 17:30 sharp. Family portraits at the marble courtyard.',
        status: BookingStatus.confirmed,
        createdAt: DateTime(2026, 10, 1),
        packagePrice: 3400.0,
        addonsTotal: 450.0,
        serviceFee: 150.0,
        tax: 280.0,
        insuranceFee: 95.0,
        discount: 100.0,
        totalAmount: 4275.0,
        paymentMethodTitle: 'Eventora Escrow Wallet',
        paymentTransactionId: 'TXN-994821',
        isEscrowProtected: true,
        timeline: [
          const BookingTimelineEvent(
              title: 'Reservation Placed',
              time: 'Oct 01, 10:30 AM',
              description:
                  'Booking request sent with 50% escrow deposit held safely.',
              isCompleted: true),
          const BookingTimelineEvent(
              title: 'Provider Confirmed',
              time: 'Oct 01, 11:15 AM',
              description:
                  'Elena Rostova approved date and locked calendar schedule.',
              isCompleted: true),
          const BookingTimelineEvent(
              title: 'Lead Crew Assigned',
              time: 'Oct 03, 02:00 PM',
              description:
                  '2 Lead shooters and 1 drone operator allocated for your event.',
              isCompleted: true),
          const BookingTimelineEvent(
              title: 'Pre-Event Consultation',
              time: 'Scheduled for Nov 10',
              description:
                  'Video walkthrough of shotlist and schedule with Elena.',
              isCompleted: false),
          const BookingTimelineEvent(
              title: 'Day-of Execution',
              time: 'Nov 20, 03:00 PM',
              description: 'On-site arrival and master photography session.',
              isCompleted: false),
        ],
      ),
      Booking(
        id: 'EVT-2026-9102',
        service: services[2], // Maison De L'Or Catering
        selectedPackage: services[2].packages[1], // 5-course Grand Epicurean
        selectedAddons: [services[2].availableAddons[0]],
        eventDate: DateTime(2026, 12, 15),
        eventTime: '18:00 - 23:00',
        eventLocation: 'The Penthouse at Hudson Yards, NYC',
        eventType: 'Milestone Celebration',
        guestCount: 85,
        specialRequests:
            '2 gluten-free tasting menus, 1 vegan option. Champagne tower toast at 20:00.',
        status: BookingStatus.vendorAssigned,
        createdAt: DateTime(2026, 9, 20),
        packagePrice: 4800.0,
        addonsTotal: 950.0,
        serviceFee: 220.0,
        tax: 410.0,
        insuranceFee: 120.0,
        discount: 0.0,
        totalAmount: 6500.0,
        paymentMethodTitle: 'Amex Platinum (•••• 4018)',
        paymentTransactionId: 'TXN-773192',
        isEscrowProtected: true,
        timeline: [
          const BookingTimelineEvent(
              title: 'Reservation Placed',
              time: 'Sep 20, 04:00 PM',
              description: 'Initial booking request submitted.',
              isCompleted: true),
          const BookingTimelineEvent(
              title: 'Menu Finalized & Approved',
              time: 'Sep 22, 11:00 AM',
              description:
                  'Chef Antoine approved customized 5-course pairings.',
              isCompleted: true),
          const BookingTimelineEvent(
              title: 'Service Staff Locked',
              time: 'Sep 25, 03:30 PM',
              description: 'Sommelier and 10 white-glove servers scheduled.',
              isCompleted: true),
          const BookingTimelineEvent(
              title: 'Tasting & Rehearsal',
              time: 'Scheduled for Nov 28',
              description: 'Private kitchen tasting at San Francisco atelier.',
              isCompleted: false),
        ],
      ),
      Booking(
        id: 'EVT-2026-5510',
        service: services[1], // Bel-Air Pavilion
        selectedPackage: services[1].packages[0], // Sunset Terrace
        selectedAddons: [],
        eventDate: DateTime(2026, 8, 10),
        eventTime: '16:00 - 22:00',
        eventLocation: 'Bel-Air Pavilion, Los Angeles, CA',
        eventType: 'Corporate Banquet',
        guestCount: 120,
        specialRequests: 'Valet setup ready by 15:30.',
        status: BookingStatus.completed,
        createdAt: DateTime(2026, 7, 01),
        packagePrice: 4500.0,
        addonsTotal: 0.0,
        serviceFee: 180.0,
        tax: 360.0,
        insuranceFee: 95.0,
        discount: 200.0,
        totalAmount: 4935.0,
        paymentMethodTitle: 'Eventora Wallet',
        paymentTransactionId: 'TXN-410982',
        isEscrowProtected: true,
        timeline: [
          const BookingTimelineEvent(
              title: 'Reservation Completed',
              time: 'Aug 10, 11:00 PM',
              description: 'Event concluded smoothly with 5-star review.',
              isCompleted: true),
        ],
      ),
    ];
  }

  static List<WalletTransaction> getInitialTransactions() {
    return [
      WalletTransaction(
        id: 'tx-001',
        type: TransactionType.topUp,
        title: 'Wallet Top-Up via Apple Pay',
        description: 'Instant funds deposited to Celebration Escrow Wallet',
        amount: 5000.0,
        date: DateTime(2026, 10, 1, 09, 15),
        referenceNumber: 'REF-TOPUP-88910',
      ),
      WalletTransaction(
        id: 'tx-002',
        type: TransactionType.bookingPayment,
        title: 'Booking Escrow Hold: Aurelia Photography',
        description: 'Deposit held safely for Booking #EVT-2026-8841',
        amount: -4275.0,
        date: DateTime(2026, 10, 1, 10, 30),
        referenceNumber: 'TXN-994821',
        relatedBookingId: 'EVT-2026-8841',
      ),
      WalletTransaction(
        id: 'tx-003',
        type: TransactionType.cashbackReward,
        title: 'Celebration Luxe 3% Loyalty Cash Back',
        description: 'Reward on completed venue reservation #EVT-2026-5510',
        amount: 148.0,
        date: DateTime(2026, 8, 12, 14, 00),
        referenceNumber: 'CB-88391',
      ),
      WalletTransaction(
        id: 'tx-004',
        type: TransactionType.topUp,
        title: 'Wallet Top-Up via Bank Wire',
        description: 'Chase Private Client direct transfer',
        amount: 3000.0,
        date: DateTime(2026, 7, 28, 11, 45),
        referenceNumber: 'REF-WIRE-33109',
      ),
    ];
  }

  static List<PaymentMethodItem> getPaymentMethods() {
    return const [
      PaymentMethodItem(
        id: 'pm-wallet',
        type: PaymentMethodType.wallet,
        title: 'Eventora Luxe Wallet',
        subtitle: 'Fast checkout & 100% Escrow Protection',
        isDefault: true,
      ),
      PaymentMethodItem(
        id: 'pm-amex',
        type: PaymentMethodType.creditCard,
        title: 'American Express Platinum',
        subtitle: 'Expires 08/29',
        cardBrand: 'AMEX',
        last4: '4018',
        expiryDate: '08/29',
      ),
      PaymentMethodItem(
        id: 'pm-visa',
        type: PaymentMethodType.creditCard,
        title: 'Chase Sapphire Reserve Visa',
        subtitle: 'Expires 12/28',
        cardBrand: 'VISA',
        last4: '9921',
        expiryDate: '12/28',
      ),
      PaymentMethodItem(
        id: 'pm-apple',
        type: PaymentMethodType.applePay,
        title: 'Apple Pay',
        subtitle: 'Linked to Default Wallet',
      ),
    ];
  }

  static List<FaqItem> getFaqs() {
    return const [
      FaqItem(
        id: 'faq-1',
        category: 'Booking & Escrow',
        question: 'How does Eventora Escrow Protection safeguard my payment?',
        answer:
            'When you book a service on Eventora, your funds are securely held in an insured escrow account. The vendor only receives disbursement after your milestone event is executed successfully and you have signed off.',
      ),
      FaqItem(
        id: 'faq-2',
        category: 'Booking & Escrow',
        question: 'What is the cancellation and refund policy?',
        answer:
            'Standard bookings are eligible for a 100% full refund up to 7 days before your event. Cancellation between 7 days and 48 hours receives a 50% refund. Rescheduling is complimentary depending on provider calendar availability.',
      ),
      FaqItem(
        id: 'faq-3',
        category: 'Vendors & Quality',
        question: 'How are Eventora Verified Partners vetted?',
        answer:
            'All Eventora providers undergo rigorous four-tier vetting: active commercial liability insurance validation, verified client portfolio audits, background checks, and an in-person hospitality benchmark review.',
      ),
      FaqItem(
        id: 'faq-4',
        category: 'Payments & Wallet',
        question: 'Can I split payments or top up my wallet in installments?',
        answer:
            'Yes! You can top up your Eventora Wallet in advance or place a 50% reservation deposit at checkout, with the remaining balance auto-charged 14 days before your event date.',
      ),
      FaqItem(
        id: 'faq-5',
        category: 'Event Support',
        question: 'What if I need emergency changes on my event day?',
        answer:
            'Every active booking includes direct 24/7 access to our VIP Concierge Dispatch and your assigned Lead Producer via the in-app Support Center.',
      ),
    ];
  }
}
