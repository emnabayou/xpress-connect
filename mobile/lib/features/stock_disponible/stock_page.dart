import 'package:flutter/material.dart';
import 'package:xcmobile/features/stock_disponible/dsa_section/dsa_section.dart';
import 'package:xcmobile/features/stock_disponible/pre_section/pre_section.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final _sections = ['dsa', 'pre'];
  Set<String> _selected = {"dsa"};
  String selectedSection = "dsa";
  final _pageController = PageController();

  _onSelectionChanged(Set<String> values) {
    _pageController.animateToPage(
      curve: Curves.easeInOut,
      duration:const Duration(milliseconds: 220)
      ,_sections.indexOf(values.first));
    setState(() {
      _selected = values;
      selectedSection = values.first;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          SegmentedButton(
            segments: const [
              ButtonSegment(
                  label: Text("DSA"),
                  icon: Icon(Icons.sim_card_outlined),
                  value: "dsa"),
              ButtonSegment(
                  label: Text("Pré-Déclaré"),
                  icon: Icon(Icons.history),
                  value: "pre")
            ],
            selected: _selected,
            onSelectionChanged: _onSelectionChanged,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [DSASection(), PreDeclareSection()],
              onPageChanged: (index) {
                setState(() {
                  _selected = {(_sections[index])};
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
