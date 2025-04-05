import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class GrivaLoginPage extends StatefulWidget {
  const GrivaLoginPage({Key? key}) : super(key: key);

  @override
  _GrivaLoginPageState createState() => _GrivaLoginPageState();
}

class _GrivaLoginPageState extends State<GrivaLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  final String _validEmail = 'doctor@griva.com';
  final String _validPassword = 'GrivaDoc2024!';

  @override
  void initState() {
    super.initState();
    // Prepopulate the email and password fields
    _emailController.text = _validEmail;
    _passwordController.text = _validPassword;
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    if (_emailController.text == _validEmail &&
        _passwordController.text == _validPassword) {
      // Successful login
      _showSuccessDialog('Login Successful');
    } else {
      // Failed login
      _showErrorDialog('Invalid email or password');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Try Again'),
              ),
            ],
          ),
    );
  }

  // void _contactAdmin() async {
  //   // You can customize this with your actual contact method
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'admin@griva.com',
  //     query: encodeQueryParameters(<String, String>{
  //       'subject': 'Griva Colposcope - Account Access Request',
  //     }),
  //   );

  //   try {
  //     if (await canLaunchUrl(emailLaunchUri)) {
  //       await launchUrl(emailLaunchUri);
  //     } else {
  //       _showErrorDialog('Could not launch email app');
  //     }
  //   } catch (e) {
  //     _showErrorDialog('An error occurred. Please contact admin via email.');
  //   }
  // }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  void _forgotPassword() {
    _showErrorDialog('Please contact the admin to reset your password.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'GRIVA',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    ' Colposcope',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              // Welcome Text
              Text(
                'Welcome Doctor!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Please sign in to continue',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 32),

              // Email TextField
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Remember Me and Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: Colors.purple[300],
                      ),
                      Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: _forgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Login Button
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[300],
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Log In', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16),

              // New to Griva
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New to Griva Colposcope?'),
                  TextButton(
                    onPressed: () {
                      // Implement contact admin logic
                    },
                    child: Text(
                      'Contact the Admin',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Terms and Privacy
              Text(
                'By signing in, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
