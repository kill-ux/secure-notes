import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:secure_notes/screens/notes_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticating = false;
  String _message = 'Press the button to authenticate';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate);
  }

  Future<void> _authenticate() async {
    final bool canCheck = await _auth.canCheckBiometrics;
    print("################### canCheck =>");
    print(canCheck);
    final bool isDeviceSupported = await _auth.isDeviceSupported();
    print("################### isDeviceSupported =>");
    print(isDeviceSupported);
    final bool canAuthenticate = canCheck || isDeviceSupported;

    if (!canAuthenticate) {
      setState(() {
        _message = 'Biometrics not available on this device';
      });
      return;
    }

    try {
      setState(() {
        _isAuthenticating = true;
        _message = 'Authenticating...';
      });

      final bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to access your secure notes',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );

      if (!mounted) return;
      if (authenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NotesScreen()),
        );
      } else {
        setState(() => _message = 'Authentication failed. Try again.');
      }
    } catch (e) {
      setState(() => _message = 'Error: ${e.toString()}');
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.white),
            const SizedBox(height: 24),
            const Text(
              'Secure Notes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            const SizedBox(height: 32),
            _isAuthenticating
                ? const CircularProgressIndicator(color: Colors.white)
                : ElevatedButton.icon(
                    onPressed: _authenticate,
                    icon: const Icon(Icons.fingerprint),
                    label: const Text('Authenticate'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
