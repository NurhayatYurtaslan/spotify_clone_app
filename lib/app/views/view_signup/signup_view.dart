import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/widgets/basic_app_button.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';
import 'view_model/signup_event.dart';
import 'view_model/signup_state.dart';
import 'view_model/signup_view_model.dart';

@RoutePage()
class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isLengthValid = false;
  bool isUpperCaseValid = false;
  bool isLowerCaseValid = false;
  bool isDigitValid = false;
  bool isSpecialCharacterValid = false;
  bool isPasswordVisible = false; // Şifre görünürlük durumu

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupViewModel(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: SvgPicture.asset(
                Assets.images.svg.spotifyLogo,
                height: context.mediumValue,
                width: context.highValue,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<SignupViewModel>().add(BackToSigninEvent(context));
                },
              ),
            ),
            body: BlocListener<SignupViewModel, SignupState>(
              listener: (context, state) {
                if (state is SignupSuccessState) {
                  // Başarı durumunda Snackbar göster ve Signin sayfasına yönlendir
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Üyeliğiniz tamamlandı!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );

                  // 2 saniye bekle ve ardından Signin sayfasına yönlendir
                  Future.delayed(const Duration(seconds: 2), () {
                    context.router.replace(const SigninViewRoute());
                  });
                } else if (state is SignupFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.errorColor,
                      content: Text(state.errorMessage),
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(context.mediumValue),
                  child: Column(
                    children: [
                      _buildUsernameField(context),
                      context.sizedHeightBoxHigh,
                      _buildEmailField(context),
                      context.sizedHeightBoxHigh,
                      _buildPasswordField(context),
                      context.sizedHeightBoxHigh,
                      _buildPasswordCriteria(),
                      context.sizedHeightBoxHigh,
                      BasicAppButton(
                        onPressed: () {
                          context.read<SignupViewModel>().add(
                            SignupInitialEvent(context),
                          );
                        },
                        title: 'Sign Up',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  TextField _buildUsernameField(BuildContext context) {
    return TextField(
      controller: context.read<SignupViewModel>().usernameController,
      decoration: const InputDecoration(labelText: 'Username'),
    );
  }

  TextField _buildEmailField(BuildContext context) {
    return TextField(
      controller: context.read<SignupViewModel>().emailController,
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }

  TextField _buildPasswordField(BuildContext context) {
    return TextField(
      controller: context.read<SignupViewModel>().passwordController,
      obscureText: !isPasswordVisible, // Şifre görünürlüğünü ayarlama
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
      ),
      onChanged: (password) {
        setState(() {
          isLengthValid = password.length >= 8;
          isUpperCaseValid = password.contains(RegExp(r'[A-Z]'));
          isLowerCaseValid = password.contains(RegExp(r'[a-z]'));
          isDigitValid = password.contains(RegExp(r'[0-9]'));
          isSpecialCharacterValid = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
        });
      },
    );
  }

  Column _buildPasswordCriteria() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password must meet the following criteria:'),
        _buildCriteriaRow('At least 8 characters', isLengthValid),
        _buildCriteriaRow('At least 1 uppercase letter', isUpperCaseValid),
        _buildCriteriaRow('At least 1 lowercase letter', isLowerCaseValid),
        _buildCriteriaRow('At least 1 digit', isDigitValid),
        _buildCriteriaRow('At least 1 special character', isSpecialCharacterValid),
      ],
    );
  }

  Row _buildCriteriaRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? Colors.green : Colors.red,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
