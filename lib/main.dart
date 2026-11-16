import 'package:flutter/material.dart';
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
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController weightController = TextEditingController();

  final TextEditingController rateController = TextEditingController();

  String ticketClass = 'Economy';

  double excessWeight = 0;
  double excessCharge = 0;
  double serviceTax = 0;
  double totalPayable = 0;

  bool calculated = false;

  void calculateFee() {
    double? baggageWeight = double.tryParse(weightController.text);

    double? rate = double.tryParse(rateController.text);

    if (baggageWeight == null ||
        rate == null ||
        baggageWeight < 0 ||
        rate < 0 ||
        weightController.text.isEmpty ||
        rateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid baggage weight and rate.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double allowance = ticketClass == 'Economy' ? 20 : 40;

    setState(() {
      excessWeight = baggageWeight > allowance ? baggageWeight - allowance : 0;

      excessCharge = excessWeight * rate;

      serviceTax = excessCharge * 0.08;

      totalPayable = excessCharge + serviceTax;

      calculated = true;
    });
  }

  void resetCalculator() {
    setState(() {
      weightController.clear();
      rateController.clear();

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
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Baggage Fee Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.flight_takeoff, color: Colors.white, size: 45),
                  SizedBox(height: 10),
                  Text(
                    'Baggage Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.luggage, size: 65, color: Colors.indigo),

            const SizedBox(height: 10),

            const Text(
              'Excess Baggage Calculator',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              'Calculate your additional baggage fee easily.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // Baggage Weight Input
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
              decoration: InputDecoration(
                hintText: 'Enter baggage weight',
                prefixIcon: const Icon(Icons.scale),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Ticket Class Selection
            const Text(
              'Ticket Class',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: ticketClass,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.airplane_ticket),
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

            // Rate Input
            const Text(
              'Excess Baggage Rate (RM/kg)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: rateController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: 'Enter rate per kg',
                prefixIcon: const Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 25),

            // Calculate Button
            ElevatedButton.icon(
              onPressed: calculateFee,
              icon: const Icon(Icons.calculate),
              label: const Text('Calculate Fee'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
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
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
              style: OutlinedButton.styleFrom(
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

              resultRow(
                'Excess Baggage Weight',
                '${excessWeight.toStringAsFixed(2)} kg',
              ),

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
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
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
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ABOUT PAGE

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const githubUrl = 'https://github.com/4iimxn/Baggage-Fee-Calculator-MFA';

    return Scaffold(
      appBar: AppBar(
        title: const Text('About', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            children: [
              const Icon(Icons.flight_takeoff, size: 90, color: Colors.indigo),

              const SizedBox(height: 20),

              const Text(
                'Baggage Fee Calculator',
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
                  'BACHELOR OF COMPUTER SCIENCE (HONS) NETCENTRIC COMPUTING',
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
                child: Text(
                  githubUrl,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                '© 2026 Baggage Fee Calculator. '
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
