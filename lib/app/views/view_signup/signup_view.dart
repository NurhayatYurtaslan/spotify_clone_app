import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/widgets/app_bar.dart';
import 'package:spotify_clone_app/core/widgets/basic_app_button.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';
import 'view_model/signup_event.dart';
import 'view_model/signup_state.dart';
import 'view_model/signup_view_model.dart';

@RoutePage()
class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupViewModel(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: BasicAppbar(
              title: SvgPicture.asset(
                Assets.images.svg.spotifyLogo,
                height: context.mediumValue,
                width: context.highValue,
              ),
              onPressed: () {
                context.read<SignupViewModel>().add(BackEvent(context));
              },
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(context.mediumValue),
              child: Column(
                children: [
                  _buildUsernameField(context),
                  context.sizedHeightBoxHigh,
                  _buildEmailField(context),
                  context.sizedHeightBoxHigh,
                  _buildPasswordField(context),
                  context.sizedHeightBoxHigh,
                  _buildSignupButton(context),
                  context.sizedHeightBoxLow,
                  _buildSigninPrompt(context),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  TextFormField _buildUsernameField(BuildContext context) {
    final viewModel = context.read<SignupViewModel>();
    return TextFormField(
      controller: viewModel.usernameController,
      decoration: const InputDecoration(labelText: 'Username'),
    );
  }

  TextFormField _buildEmailField(BuildContext context) {
    final viewModel = context.read<SignupViewModel>();
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: viewModel.emailController,
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    final viewModel = context.read<SignupViewModel>();
    return BlocBuilder<SignupViewModel, SignupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: viewModel.passwordController,
              focusNode: viewModel.passwordFocusNode,
              obscureText: !viewModel.isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    viewModel.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    viewModel.togglePasswordVisibility();
                  },
                ),
              ),
              onTap: () {
                viewModel.togglePasswordRequirementsVisibility();
              },
              onChanged: (value) {
                viewModel.add(CheckPasswordRequirementsEvent());
              },
            ),
            if (viewModel.passwordRequirementsVisible)
              _buildPasswordRequirements(viewModel),
          ],
        );
      },
    );
  }

  Widget _buildPasswordRequirements(SignupViewModel viewModel) {
    return Column(
      children: [
        _buildRequirementRow('At least 8 characters', viewModel.passwordRequirementsMet[0]),
        _buildRequirementRow('One uppercase letter', viewModel.passwordRequirementsMet[1]),
        _buildRequirementRow('One lowercase letter', viewModel.passwordRequirementsMet[2]),
        _buildRequirementRow('One number', viewModel.passwordRequirementsMet[3]),
        _buildRequirementRow('One special character (e.g., @, #, \$, %, &, .)', viewModel.passwordRequirementsMet[4]),
      ],
    );
  }

  Widget _buildRequirementRow(String requirement, bool isMet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(requirement),
        Icon(
          isMet ? Icons.check : Icons.close,
          color: isMet ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    final viewModel = context.read<SignupViewModel>();
    return BasicAppButton(
      onPressed: () {
        viewModel.add(SignupInitialEvent(context));
      },
      title: 'Sign Up',
    );
  }

  Widget _buildSigninPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Have An Account?',
          style: TextStyle(fontSize: context.normalValue * 1.2),
        ),
        context.sizedWidthBoxLow,
        InkWell(
          onTap: () {
            context.read<SignupViewModel>().add(SigninEvent(context));
          },
          child: Text(
            'Sign In Now',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: context.normalValue * 1.2,
            ),
          ),
        ),
      ],
    );
  }
}