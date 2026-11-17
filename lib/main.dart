import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const BaggageApp());
}

class BaggageApp extends StatelessWidget {
  const BaggageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baggage Fee Calculator',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F5FC),
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5146E5)),
      ),
      home: const HomePage(),
    );
  }
}

// ==========================================
// HOME PAGE
// ==========================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5146E5), Color(0xFF7867F5), Color(0xFF9C8CFF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white30, width: 2),
                    ),
                    child: const Icon(
                      Icons.flight_takeoff_rounded,
                      size: 75,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    'WELCOME ABOARD!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Your Journey Starts Here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Plan your luggage, check your baggage allowance, '
                    'and calculate any additional baggage fees '
                    'before your next flight.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalculatorPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calculate_rounded, size: 23),
                      label: const Text(
                        'GO TO CALCULATOR',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF5146E5),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'TRAVEL SMART. PACK SMART.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// NAVIGATION DRAWER
// ==========================================

class AppDrawer extends StatelessWidget {
  final String currentPage;

  const AppDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 190,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5146E5), Color(0xFF8979F5)],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.flight_takeoff_rounded,
                    color: Colors.white,
                    size: 45,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Baggage Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your travel companion',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            leading: Icon(
              Icons.home_rounded,
              color: currentPage == 'Home'
                  ? const Color(0xFF5146E5)
                  : Colors.grey,
            ),
            title: const Text('Home'),
            selected: currentPage == 'Home',
            selectedTileColor: const Color(0xFFECEBFF),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
          ),

          ListTile(
            leading: Icon(
              Icons.calculate_rounded,
              color: currentPage == 'Calculator'
                  ? const Color(0xFF5146E5)
                  : Colors.grey,
            ),
            title: const Text('Calculator'),
            selected: currentPage == 'Calculator',
            selectedTileColor: const Color(0xFFECEBFF),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CalculatorPage()),
                (route) => false,
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
            selected: currentPage == 'About',
            selectedTileColor: const Color(0xFFECEBFF),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ==========================================
// CALCULATOR PAGE
// ==========================================

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController weightController = TextEditingController();

  String ticketClass = 'Economy';

  double excessWeight = 0;
  double excessCharge = 0;
  double serviceTax = 0;
  double totalPayable = 0;

  bool calculated = false;

  // Automatically determine rate based on ticket class.
  double get baggageRate {
    return ticketClass == 'Economy' ? 15.0 : 12.0;
  }

  // Automatically determine baggage allowance.
  double get baggageAllowance {
    return ticketClass == 'Economy' ? 20.0 : 40.0;
  }

  void calculateFee() {
    double? baggageWeight = double.tryParse(weightController.text);

    if (baggageWeight == null ||
        baggageWeight < 0 ||
        weightController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid baggage weight.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      excessWeight = baggageWeight > baggageAllowance
          ? baggageWeight - baggageAllowance
          : 0;

      // Automatically use the rate for the selected class.
      excessCharge = excessWeight * baggageRate;

      serviceTax = excessCharge * 0.08;

      totalPayable = excessCharge + serviceTax;

      calculated = true;
    });

    FocusScope.of(context).unfocus();
  }

  void resetCalculator() {
    setState(() {
      weightController.clear();

      ticketClass = 'Economy';

      excessWeight = 0;
      excessCharge = 0;
      serviceTax = 0;
      totalPayable = 0;

      calculated = false;
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Baggage Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF5146E5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: const AppDrawer(currentPage: 'Calculator'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),

            const Icon(
              Icons.luggage_rounded,
              size: 65,
              color: Color(0xFF5146E5),
            ),

            const SizedBox(height: 10),

            const Text(
              'Excess Baggage Fee Calculator',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              'Calculate your additional baggage fee easily.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            // Baggage Weight
            const Text(
              'Baggage Weight (kg)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) {
                setState(() => calculated = false);
              },
              decoration: InputDecoration(
                hintText: 'Enter baggage weight',
                prefixIcon: const Icon(Icons.scale_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Ticket Class
            const Text(
              'Ticket Class',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: ticketClass,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.airplane_ticket_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Economy',
                  child: Text('Economy (20 kg)'),
                ),
                DropdownMenuItem(
                  value: 'Business',
                  child: Text('Business (40 kg)'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  ticketClass = value!;
                  calculated = false;
                });
              },
            ),

            const SizedBox(height: 20),

            // AUTOMATIC EXCESS BAGGAGE RATE
            const Text(
              'Excess Baggage Rate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
              decoration: BoxDecoration(
                color: const Color(0xFFECEBFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF5146E5).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.payments_rounded, color: Color(0xFF5146E5)),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Automatically Applied Rate',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          'RM ${baggageRate.toStringAsFixed(2)} / kg',
                          style: const TextStyle(
                            color: Color(0xFF5146E5),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFF5146E5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Calculate Button
            ElevatedButton.icon(
              onPressed: calculateFee,
              icon: const Icon(Icons.calculate_rounded),
              label: const Text('Calculate Fee'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5146E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Reset Button
            OutlinedButton.icon(
              onPressed: resetCalculator,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reset'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF5146E5),
                padding: const EdgeInsets.all(14),
              ),
            ),

            const SizedBox(height: 25),

            // Calculation Results
            if (calculated) ...[
              const Divider(thickness: 1),

              const Text(
                'Calculation Results',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              resultRow('Ticket Class', ticketClass),

              resultRow(
                'Baggage Allowance',
                '${baggageAllowance.toStringAsFixed(0)} kg',
              ),

              resultRow(
                'Excess Baggage Weight',
                '${excessWeight.toStringAsFixed(2)} kg',
              ),

              resultRow('Rate per kg', 'RM ${baggageRate.toStringAsFixed(2)}'),

              resultRow(
                'Excess Baggage Charge',
                'RM ${excessCharge.toStringAsFixed(2)}',
              ),

              resultRow(
                'Service Tax (8%)',
                'RM ${serviceTax.toStringAsFixed(2)}',
              ),

              const Divider(),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF5146E5),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5146E5).withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'TOTAL AMOUNT PAYABLE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'RM ${totalPayable.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              if (excessWeight == 0) ...[
                const SizedBox(height: 15),
                const Text(
                  'Your baggage is within the allowed limit!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget resultRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ABOUT PAGE
// ==========================================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const githubUrl = 'https://github.com/4iimxn/Baggage-Fee-Calculator-MFA';

    return Scaffold(
      appBar: AppBar(
        title: const Text('About', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF5146E5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: const AppDrawer(currentPage: 'About'),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              // PROFILE IMAGE
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF5146E5), width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5146E5).withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 65,
                  backgroundColor: Color(0xFFECEBFF),
                  backgroundImage: AssetImage('assets/images/faris.jpg'),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'MUHAMMAD FARIS AIMAN BIN RAIEE',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              const Text(
                'Student Developer',
                style: TextStyle(
                  color: Color(0xFF5146E5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 25),

              const Icon(
                Icons.flight_takeoff_rounded,
                size: 65,
                color: Color(0xFF5146E5),
              ),

              const SizedBox(height: 20),

              const Text(
                'MFA Greatest Baggage Fee Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                'A mobile application developed to estimate '
                'excess baggage fees for air travel.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 30),

              const Divider(),

              const Text(
                'AUTHOR INFORMATION',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              const SizedBox(height: 15),

              const ListTile(
                leading: Icon(Icons.person),
                title: Text('Name'),
                subtitle: Text('MUHAMMAD FARIS AIMAN BIN RAIEE'),
              ),

              const ListTile(
                leading: Icon(Icons.badge),
                title: Text('Matric Number'),
                subtitle: Text('2024409966'),
              ),

              const ListTile(
                leading: Icon(Icons.school),
                title: Text('Course'),
                subtitle: Text(
                  'BACHELOR OF COMPUTER SCIENCE '
                  '(HONS) NETCENTRIC COMPUTING',
                ),
              ),

              const Divider(),

              const SizedBox(height: 15),

              const Text(
                'GitHub Repository',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              const SizedBox(height: 10),

              InkWell(
                onTap: () async {
                  final launched = await launchUrl(
                    Uri.parse(githubUrl),
                    mode: LaunchMode.externalApplication,
                  );

                  if (!launched && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Could not open the GitHub repository.'),
                      ),
                    );
                  }
                },
                child: const Text(
                  githubUrl,
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                '© 2026 MFA Greatest Baggage Fee Calculator. '
                'ICT602 INDIVIDUAL ASSIGNMENT. '
                'All Rights Reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
