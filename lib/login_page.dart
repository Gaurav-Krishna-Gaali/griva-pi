import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'services/user_service.dart';
import 'widgets/centralized_footer.dart';

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
  bool _isSignupMode = false;

  // Signup form controllers
  final _signupNameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _signupConfirmPasswordController = TextEditingController();
  final _signupLicenseController = TextEditingController();
  final _signupHospitalController = TextEditingController();
  bool _obscureSignupPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSignupLoading = false;

  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    // Prepopulate with default admin credentials for testing
    _emailController.text = 'admin@griva.com';
    _passwordController.text = 'admin123';
  }

  void _toggleMode() {
    setState(() {
      _isSignupMode = !_isSignupMode;
    });
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _userService.authenticateUser(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (user != null) {
        // Successful login
        _showSuccessDialog('Welcome back, ${user.fullName}!');
      } else {
        // Failed login
        _showErrorDialog('Invalid email or password. Please check your credentials.');
      }
    } catch (e) {
      _showErrorDialog('Login failed: ${e.toString()}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _signup() async {
    // Validate signup form
    if (!_validateSignupForm()) {
      return;
    }

    setState(() {
      _isSignupLoading = true;
    });

    try {
      // Check if email already exists
      final existingUser = await _userService.getUserByEmail(_signupEmailController.text.trim());
      if (existingUser != null) {
        _showErrorDialog('An account with this email already exists.');
        setState(() {
          _isSignupLoading = false;
        });
        return;
      }

      // Create new user (automatically approved)
      final newUser = User(
        fullName: _signupNameController.text.trim(),
        email: _signupEmailController.text.trim(),
        password: _signupPasswordController.text,
        medicalLicense: _signupLicenseController.text.trim(),
        hospital: _signupHospitalController.text.trim(),
        role: 'doctor', // New users are automatically approved as doctors
        isActive: true, // Automatically active
      );

      await _userService.createUser(newUser);
      
      // Clear form
      _signupNameController.clear();
      _signupEmailController.clear();
      _signupPasswordController.clear();
      _signupConfirmPasswordController.clear();
      _signupLicenseController.clear();
      _signupHospitalController.clear();

      _showSuccessDialog('Account created successfully! You can now log in with your credentials.');
      
    } catch (e) {
      _showErrorDialog('Signup failed: ${e.toString()}');
    }

    setState(() {
      _isSignupLoading = false;
    });
  }

  bool _validateSignupForm() {
    if (_signupNameController.text.trim().isEmpty) {
      _showErrorDialog('Please enter your full name');
      return false;
    }
    
    if (_signupEmailController.text.trim().isEmpty) {
      _showErrorDialog('Please enter your email');
      return false;
    }
    
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_signupEmailController.text)) {
      _showErrorDialog('Please enter a valid email address');
      return false;
    }
    
    if (_signupPasswordController.text.length < 8) {
      _showErrorDialog('Password must be at least 8 characters long');
      return false;
    }
    
    if (_signupPasswordController.text != _signupConfirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return false;
    }
    
    if (_signupLicenseController.text.trim().isEmpty) {
      _showErrorDialog('Please enter your medical license number');
      return false;
    }
    
    if (_signupHospitalController.text.trim().isEmpty) {
      _showErrorDialog('Please enter your hospital/clinic name');
      return false;
    }
    
    return true;
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
                  if (!_isSignupMode) {
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => HomePage(userEmail: _emailController.text.trim()),
                      ),
                    );
                  } else {
                    // Switch back to login mode after successful signup
                    setState(() {
                      _isSignupMode = false;
                    });
                  }
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
      body: SingleChildScrollView(
        child: Center(
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
                  _isSignupMode ? 'Create Account' : 'Welcome Doctor!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  _isSignupMode 
                      ? 'Please fill in your details to register'
                      : 'Please sign in to continue',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 32),

                // Form Content
                if (_isSignupMode) _buildSignupForm() else _buildLoginForm(),

                SizedBox(height: 16),

                // Toggle between Login and Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_isSignupMode 
                        ? 'Already have an account?'
                        : 'New to Griva Colposcope?'),
                    TextButton(
                      onPressed: _toggleMode,
                      child: Text(
                        _isSignupMode ? 'Sign In' : 'Sign Up',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Terms and Privacy
                Text(
                  'By ${_isSignupMode ? 'creating an account' : 'signing in'}, you agree to our Terms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                SizedBox(height: 32), // Add extra padding at bottom
                
                // Centralized Footer
                const CentralizedFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      children: [
        // Full Name TextField
        TextField(
          controller: _signupNameController,
          decoration: InputDecoration(
            hintText: 'Enter your full name',
            prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Email TextField
        TextField(
          controller: _signupEmailController,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Password TextField
        TextField(
          controller: _signupPasswordController,
          obscureText: _obscureSignupPassword,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureSignupPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureSignupPassword = !_obscureSignupPassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Confirm Password TextField
        TextField(
          controller: _signupConfirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            hintText: 'Confirm your password',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Medical License TextField
        TextField(
          controller: _signupLicenseController,
          decoration: InputDecoration(
            hintText: 'Medical License Number',
            prefixIcon: Icon(Icons.medical_services_outlined, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Hospital/Clinic TextField
        TextField(
          controller: _signupHospitalController,
          decoration: InputDecoration(
            hintText: 'Hospital/Clinic Name',
            prefixIcon: Icon(Icons.local_hospital_outlined, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Signup Button
        ElevatedButton(
          onPressed: _isSignupLoading ? null : _signup,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[300],
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child:
              _isSignupLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Create Account', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signupNameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _signupConfirmPasswordController.dispose();
    _signupLicenseController.dispose();
    _signupHospitalController.dispose();
    super.dispose();
  }
}
