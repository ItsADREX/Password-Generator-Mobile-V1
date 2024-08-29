import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/password_generator.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() => _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  String _password = '';
  double _passwordLength = 12;
  List<String> _passwordHistory = [];
  final PasswordGenerator _generator = PasswordGenerator();

  @override
  void initState() {
    super.initState();
    _generatePassword();
  }

  void _generatePassword() {
    String newPassword = _generator.generatePassword(_passwordLength.round());
    setState(() {
      _password = newPassword;
      _passwordHistory.insert(0, newPassword);
      if (_passwordHistory.length > 5) {
        _passwordHistory.removeLast();
      }
    });
  }

  String _getPasswordStrength() {
    return _generator.getPasswordStrength(_password);
  }

  Color _getStrengthColor() {
    switch (_getPasswordStrength()) {
      case 'Strong':
        return Colors.green;
      case 'Moderate':
        return Colors.orange;
      case 'Weak':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Color.fromARGB(147, 26, 43, 58)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Password Generator',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SelectableText(
                          _password,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Strength: ${_getPasswordStrength()}',
                              style: TextStyle(color: _getStrengthColor()),
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.copy),
                              label: Text('Copy'),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: _password));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Password copied to clipboard')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Password Length: ${_passwordLength.round()}'),
                Slider(
                  value: _passwordLength,
                  min: 6,
                  max: 30,
                  divisions: 24,
                  label: _passwordLength.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _passwordLength = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text('Generate Password'),
                  onPressed: _generatePassword,
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: 20),
                Text('Password History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: _passwordHistory.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_passwordHistory[index]),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            setState(() {
                              _password = _passwordHistory[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}