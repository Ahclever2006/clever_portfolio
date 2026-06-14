import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/core/widgets/app_text_field.dart';
import 'package:clever_portfolio/core/widgets/app_text_link.dart';
import 'package:clever_portfolio/core/widgets/section_scaffold.dart';
import 'package:clever_portfolio/features/contact/domain/entities/contact_message.dart';
import 'package:clever_portfolio/features/contact/presentation/cubit/contact_cubit.dart';
import 'package:clever_portfolio/features/contact/presentation/cubit/contact_state.dart';
import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Contact section (folio 09): direct contact details on the left and a
/// contact form on the right (stacked on mobile), per plan.md §4.
class ContactSection extends StatefulWidget {
  /// Creates a [ContactSection].
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController msgCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    msgCtrl.dispose();
    super.dispose();
  }

  /// The profile email if loaded, used for the fallback "email me" link.
  String? get _profileEmail {
    final state = context.read<ProfileCubit>().state;
    return state is ProfileLoaded ? state.profile.email : null;
  }

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      folio: '09',
      eyebrow: AppStrings.contactEyebrow.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.contactTitle.tr(), style: context.text.displayMedium),
          SizedBox(height: context.spacing.lg.h),
          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ContactDetails()),
                SizedBox(width: context.spacing.xl.w),
                Expanded(child: _ContactForm()),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactDetails(),
                SizedBox(height: context.spacing.xl.h),
                _ContactForm(),
              ],
            ),
        ],
      ),
    );
  }
}

/// Reads [ProfileCubit] and renders the direct contact details (left column).
class _ContactDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final profile = state.profile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle.merge(
          style: context.text.titleLarge,
          child: AppTextLink(
            label: profile.email,
            onTap: () => AppLauncher.email(profile.email),
          ),
        ),
        SizedBox(height: context.spacing.md.h),
        Text(
          profile.phone,
          style: context.text.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.xs.h),
        Text(
          profile.location,
          style: context.text.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.md.h),
        for (final Language lang in profile.languages) ...[
          Text(
            '${lang.name} — ${lang.level}', // no-tr
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.xs.h),
        ],
      ],
    );
  }
}

/// The contact form (right column) — name, email, message and the
/// submit button driven by [ContactCubit].
class _ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_ContactSectionState>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: AppStrings.contactName.tr(),
          controller: state.nameCtrl,
        ),
        SizedBox(height: context.spacing.md.h),
        AppTextField(
          label: AppStrings.contactEmail.tr(),
          controller: state.emailCtrl,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: context.spacing.md.h),
        AppTextField(
          label: AppStrings.contactMessage.tr(),
          controller: state.msgCtrl,
          maxLines: 5,
        ),
        SizedBox(height: context.spacing.lg.h),
        BlocConsumer<ContactCubit, ContactState>(
          listener: (context, contactState) {
            if (contactState is ContactSuccess) {
              state.nameCtrl.clear();
              state.emailCtrl.clear();
              state.msgCtrl.clear();
            }
          },
          builder: (context, contactState) {
            return switch (contactState) {
              ContactSuccess() => Text(
                AppStrings.contactSuccess.tr(),
                style: context.text.bodyMedium?.copyWith(
                  color: context.brand.success,
                ),
              ),
              ContactFailure() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.contactErrorFallback.tr(),
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.error,
                    ),
                  ),
                  SizedBox(height: context.spacing.md.h),
                  AppButton.ghost(
                    label: AppStrings.contactEmailMe.tr(),
                    onPressed: state._profileEmail == null
                        ? null
                        : () => AppLauncher.email(state._profileEmail!),
                  ),
                ],
              ),
              ContactSubmitting() => AppButton(
                label: AppStrings.contactSending.tr(),
                onPressed: null,
              ),
              _ => AppButton(
                label: AppStrings.contactSend.tr(),
                onPressed: () => context.read<ContactCubit>().submit(
                  ContactMessage(
                    name: state.nameCtrl.text,
                    email: state.emailCtrl.text,
                    message: state.msgCtrl.text,
                  ),
                ),
              ),
            };
          },
        ),
      ],
    );
  }
}
