import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/core/widgets/app_text_field.dart';
import 'package:clever_portfolio/core/widgets/reveal_on_scroll.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Contact section (folio 09): direct-line panel left + transmission form right.
/// Desktop: 40/60 asymmetric split. Mobile: stacked.
class ContactSection extends StatefulWidget {
  /// Creates a [ContactSection].
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
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

  String? get _profileEmail {
    final state = context.read<ProfileCubit>().state;
    return state is ProfileLoaded ? state.profile.email : null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    context.read<ContactCubit>().submit(
      ContactMessage(
        name: nameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        message: msgCtrl.text.trim(),
      ),
    );
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
          SizedBox(height: context.spacing.xl.h),
          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left ~40%
                Expanded(
                  flex: 4,
                  child: RevealOnScroll(
                    child: _DirectLine(profileEmail: _profileEmail),
                  ),
                ),
                SizedBox(width: context.spacing.xl.w * 1.5),
                // Right ~60%
                Expanded(
                  flex: 6,
                  child: RevealOnScroll(
                    delay: Duration(
                      milliseconds: context.motion.stagger.inMilliseconds,
                    ),
                    child: _TransmissionForm(
                      formKey: _formKey,
                      nameCtrl: nameCtrl,
                      emailCtrl: emailCtrl,
                      msgCtrl: msgCtrl,
                      onSubmit: _submit,
                      profileEmail: _profileEmail,
                      onReset: () => context.read<ContactCubit>().reset(),
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RevealOnScroll(child: _DirectLine(profileEmail: _profileEmail)),
                SizedBox(height: context.spacing.xl.h),
                RevealOnScroll(
                  delay: Duration(
                    milliseconds: context.motion.stagger.inMilliseconds,
                  ),
                  child: _TransmissionForm(
                    formKey: _formKey,
                    nameCtrl: nameCtrl,
                    emailCtrl: emailCtrl,
                    msgCtrl: msgCtrl,
                    onSubmit: _submit,
                    profileEmail: _profileEmail,
                    onReset: () => context.read<ContactCubit>().reset(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ── Direct line panel ─────────────────────────────────────────────────────────

class _DirectLine extends StatelessWidget {
  const _DirectLine({required this.profileEmail});

  final String? profileEmail;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final profile = state.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primary CTA: hoverable email
        _HoverableEmail(email: profile.email),
        SizedBox(height: context.spacing.md.h),
        Divider(color: context.colors.outline, thickness: 1, height: 1),
        SizedBox(height: context.spacing.md.h),
        // Contact details: phone + location with ▸ prefix
        _DetailRow(prefix: '▸', text: profile.phone),
        SizedBox(height: context.spacing.xs.h),
        _DetailRow(prefix: '▸', text: profile.location),
        if (profile.languages.isNotEmpty) ...[
          SizedBox(height: context.spacing.sm.h),
          for (final Language lang in profile.languages)
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: context.spacing.xs.h),
              child: _DetailRow(
                prefix: '·',
                text: '${lang.name} — ${lang.level}', // no-tr
              ),
            ),
        ],
        SizedBox(height: context.spacing.md.h),
        Divider(color: context.colors.outline, thickness: 1, height: 1),
        SizedBox(height: context.spacing.md.h),
        // Actions
        Wrap(
          spacing: context.spacing.sm.w,
          runSpacing: context.spacing.sm.h,
          children: [
            AppButton.ghost(
              label: AppStrings.contactDownloadCv.tr(),
              icon: Icons.download_outlined,
              onPressed: () => AppLauncher.open('docs/Ahmed_Maher_cv.pdf'),
            ),
            AppButton.ghost(
              label: AppStrings.contactWhatsapp.tr(),
              icon: FontAwesomeIcons.whatsapp,
              onPressed: () => AppLauncher.whatsApp(profile.phone),
            ),
          ],
        ),
      ],
    );
  }
}

class _HoverableEmail extends StatefulWidget {
  const _HoverableEmail({required this.email});

  final String email;

  @override
  State<_HoverableEmail> createState() => _HoverableEmailState();
}

class _HoverableEmailState extends State<_HoverableEmail> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _hovered ? context.colors.primary : context.colors.onSurface;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => AppLauncher.email(widget.email),
        child: AnimatedDefaultTextStyle(
          duration: context.motion.link,
          style: (context.text.titleLarge ?? const TextStyle()).copyWith(
            color: color,
            decoration: _hovered
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: context.colors.primary,
          ),
          child: Text(widget.email),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.prefix, required this.text});

  final String prefix;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$prefix  ', // no-tr
          style: AppTypography.captionMono.copyWith(
            color: context.colors.primary,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTypography.captionMono.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Transmission form ─────────────────────────────────────────────────────────

class _TransmissionForm extends StatelessWidget {
  const _TransmissionForm({
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
    required this.onSubmit,
    required this.profileEmail,
    required this.onReset,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController msgCtrl;
  final VoidCallback onSubmit;
  final String? profileEmail;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactCubit, ContactState>(
      listener: (context, state) {
        if (state is ContactSuccess) {
          nameCtrl.clear();
          emailCtrl.clear();
          msgCtrl.clear();
        }
      },
      builder: (context, state) {
        if (state is ContactSuccess) {
          return _TerminalBlock(
            isError: false,
            titleKey: AppStrings.contactSentTitle,
            bodyKey: AppStrings.contactSuccess,
            onAction: onReset,
            actionLabel: AppStrings.contactSend,
          );
        }
        if (state is ContactFailure) {
          return _TerminalBlock(
            isError: true,
            titleKey: AppStrings.contactSentTitle,
            bodyKey: AppStrings.contactErrorFallback,
            onAction: profileEmail == null
                ? onReset
                : () => AppLauncher.email(profileEmail!),
            actionLabel: profileEmail == null
                ? AppStrings.contactSend
                : AppStrings.contactEmailMe,
          );
        }

        final submitting = state is ContactSubmitting;

        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: AppStrings.contactName.tr(),
                controller: nameCtrl,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? AppStrings.contactValidateName.tr()
                    : null,
              ),
              SizedBox(height: context.spacing.md.h),
              AppTextField(
                label: AppStrings.contactEmail.tr(),
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return AppStrings.contactValidateEmail.tr();
                  }
                  final ok = RegExp(
                    r'^[\w.+-]+@[\w-]+\.[\w.]{2,}$',
                  ).hasMatch(v.trim());
                  return ok ? null : AppStrings.contactValidateEmail.tr();
                },
              ),
              SizedBox(height: context.spacing.md.h),
              AppTextField(
                label: AppStrings.contactMessage.tr(),
                controller: msgCtrl,
                maxLines: 5,
                validator: (v) => (v == null || v.trim().length < 10)
                    ? AppStrings.contactValidateMsg.tr()
                    : null,
              ),
              SizedBox(height: context.spacing.lg.h),
              SizedBox(
                width: double.infinity,
                child: submitting
                    ? AppButton(
                        label: AppStrings.contactSending.tr(),
                        onPressed: null,
                      )
                    : AppButton(
                        label: AppStrings.contactSend.tr(),
                        onPressed: onSubmit,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Terminal feedback block ───────────────────────────────────────────────────

class _TerminalBlock extends StatelessWidget {
  const _TerminalBlock({
    required this.isError,
    required this.titleKey,
    required this.bodyKey,
    required this.onAction,
    required this.actionLabel,
  });

  final bool isError;
  final String titleKey;
  final String bodyKey;
  final VoidCallback onAction;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    final accentColor = isError ? context.colors.error : context.colors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              isError ? '> ERROR' : '> ${titleKey.tr()}', // no-tr
              style: AppTypography.eyebrowMono.copyWith(color: accentColor),
            ),
          ],
        ),
        SizedBox(height: context.spacing.sm.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.spacing.md.w),
          decoration: BoxDecoration(
            border: Border.all(color: accentColor.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(context.radii.card.r),
          ),
          child: Text(
            bodyKey.tr(),
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
        ),
        SizedBox(height: context.spacing.md.h),
        AppButton.ghost(label: actionLabel.tr(), onPressed: onAction),
      ],
    );
  }
}
