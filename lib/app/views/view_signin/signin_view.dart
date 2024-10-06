import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_view_model.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_event.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_state.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/widgets/app_bar.dart';
import 'package:spotify_clone_app/core/widgets/basic_app_button.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

@RoutePage()
class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninViewModel(
        onSuccessCallback: () {
          // Successful login callback
          context.router.replace(const ChooseModeViewRoute());
        },
        onErrorCallback: (errorMessage) {
          print(errorMessage);
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.errorColor,
              content: Text(errorMessage),
            ),
          );
        },
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: BasicAppbar(
            title: SvgPicture.asset(
              Assets.images.svg.spotifyLogo,
              height: context.mediumValue,
              width: context.highValue,
            ),
            onPressed: () {
              context.read<SigninViewModel>().add(BackEvent(context));
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(context.mediumValue),
              child: BlocBuilder<SigninViewModel, SigninState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(fontSize: context.mediumValue * 1.5),
                      ),
                      context.sizedHeightBoxHigh,
                      _buildEmailField(context),
                      context.sizedHeightBoxHigh,
                      _buildPasswordField(context),
                      context.sizedHeightBoxHigh,
                      if (state is SigninLoadingState)
                        const CircularProgressIndicator(), // Loading indicator
                      BasicAppButton(
                          onPressed: () {
                            context.read<SigninViewModel>().add(
                                  SigninInitialEvent(context),
                                );
                          },
                          title: 'Sign In'),
                      context.sizedHeightBoxLow,
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.darkGrey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Or with',
                              style: TextStyle(
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.darkGrey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      context.sizedHeightBoxLow,
                      // Google ve Apple ile giriş butonları
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<SigninViewModel>().add(
                                    SigninWithGoogleEvent(context),
                                  );
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              decoration: BoxDecoration(
                                color: AppColors.lightBackground,
                                borderRadius:
                                    BorderRadius.circular(context.mediumValue),
                                border: Border.all(color: AppColors.darkGrey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.icons.svg.google, // Google ikonu
                                    height: context.mediumValue,
                                    width: context.mediumValue,
                                  ),
                                  context.sizedWidthBoxMedium,
                                  Text(
                                    'Sign in with Google',
                                    style: TextStyle(
                                      fontSize: context.mediumValue * .8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          context.sizedHeightBoxMedium,
                          // SignInWithAppleButton(
                          //   style: SignInWithAppleButtonStyle.whiteOutlined,
                          //   height: context.mediumValue * 2,
                          //   borderRadius:
                          //       BorderRadius.circular(context.mediumValue),
                          //   onPressed: () async {
                          //     final credential =
                          //         await SignInWithApple.getAppleIDCredential(
                          //       scopes: [
                          //         AppleIDAuthorizationScopes.email,
                          //         AppleIDAuthorizationScopes.fullName,
                          //       ],
                          //     );
                          //     log(credential
                          //         .toString()); // Burada log fonksiyonunu kullanın
                          //   },
                          // ),
                        ],
                      ),
                      context.sizedHeightBoxLow,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not A Member ?',
                            style:
                                TextStyle(fontSize: context.normalValue * 1.2),
                          ),
                          context.sizedWidthBoxLow,
                          InkWell(
                            onTap: () {
                              context.read<SigninViewModel>().add(
                                    RegisterEvent(context),
                                  );
                            },
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold
                                  ,
                                  fontSize: context.normalValue * 1.2),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  TextField _buildEmailField(BuildContext context) {
    return TextField(
      controller: context.read<SigninViewModel>().emailController,
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }

  TextField _buildPasswordField(BuildContext context) {
    return TextField(
      controller: context.read<SigninViewModel>().passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured; // Toggle password visibility
            });
          },
        ),
      ),
      obscureText: _isObscured,
    );
  }
}
