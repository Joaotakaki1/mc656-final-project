import 'package:flutter/material.dart';
import 'package:mc656finalproject/screens/ErrorMessageWidget.dart';

class TestErrorMessageScreen extends StatefulWidget {
  const TestErrorMessageScreen({super.key});

  @override
  _TestErrorMessageScreenState createState() => _TestErrorMessageScreenState();
}

class _TestErrorMessageScreenState extends State<TestErrorMessageScreen> {
  bool _showError = false;

  void _toggleError() {
    setState(() {
      _showError = !_showError;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Error Message Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _toggleError,
              child: const Text('Show Error Message'),
            ),
            if (_showError)
              Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.8, // Ocupa 80% da largura da tela
                  child: ErrorMessageWidget(
                    message: 'An error occurred. Please try again.',
                    onClose: _toggleError,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
