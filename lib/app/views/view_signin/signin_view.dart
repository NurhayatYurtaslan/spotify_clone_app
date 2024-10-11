import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_view_model.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_event.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_state.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/widgets/app_bar.dart';
import 'package:spotify_clone_app/core/widgets/basic_app_button.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

@RoutePage()
class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninViewModel(),
      child: BlocBuilder<SigninViewModel, SigninState>(
        builder: (context, state) {
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
                            style:
                                TextStyle(fontSize: context.mediumValue * 1.5),
                          ),
                          context.sizedHeightBoxHigh,
                          _buildEmailField(context),
                          context.sizedHeightBoxHigh,
                          _buildPasswordField(context),
                          context.sizedHeightBoxHigh,
                          if (state is SigninLoadingState)
                            const CircularProgressIndicator(),
                          BasicAppButton(
                            onPressed: () {
                              context
                                  .read<SigninViewModel>()
                                  .add(SigninInitialEvent(
                                    context,
                                    email: context
                                        .read<SigninViewModel>()
                                        .emailController
                                        .text
                                        .trim(),
                                    password: context
                                        .read<SigninViewModel>()
                                        .passwordController
                                        .text
                                        .trim(),
                                  ));
                            },
                            title: 'Sign In',
                          ),
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
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<SigninViewModel>()
                                  .add(SigninWithGoogleEvent(context: context));
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius:
                                    BorderRadius.circular(context.mediumValue),
                                border: Border.all(color: AppColors.darkGrey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.icons.svg.google,
                                    height: context.mediumValue,
                                    width: context.mediumValue,
                                  ),
                                  context.sizedWidthBoxMedium,
                                  Text(
                                    'Sign in with Google',
                                    style: TextStyle(
                                      color: AppColors.lightBackground,
                                      fontSize: context.mediumValue * .8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          context.sizedHeightBoxLow,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Not A Member?',
                                style: TextStyle(
                                    fontSize: context.normalValue * 1.2),
                              ),
                              context.sizedWidthBoxLow,
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SigninViewModel>()
                                      .add(RegisterEvent(context));
                                },
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.normalValue * 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                )
              
            ),
          );
        },
      ),
    );
  }

  TextField _buildEmailField(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: context.read<SigninViewModel>().emailController,
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }

  TextField _buildPasswordField(BuildContext context) {
    final viewModel = context.read<SigninViewModel>();
    return TextField(
      controller: viewModel.passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.isObscured ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            viewModel.add(TogglePasswordVisibilityEvent());
          },
        ),
      ),
      obscureText: viewModel.isObscured,
    );
  }
}
