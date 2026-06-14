import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
sealed class LanguageModel with _$LanguageModel {
  const LanguageModel._();
  const factory LanguageModel({required String name, required String level}) =
      _LanguageModel;
  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);
  Language toEntity() => Language(name: name, level: level);
}

@freezed
sealed class SocialLinkModel with _$SocialLinkModel {
  const SocialLinkModel._();
  const factory SocialLinkModel({required String label, required String url}) =
      _SocialLinkModel;
  factory SocialLinkModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkModelFromJson(json);
  SocialLink toEntity() => SocialLink(label: label, url: url);
}

@freezed
sealed class StatMetricModel with _$StatMetricModel {
  const StatMetricModel._();
  const factory StatMetricModel({
    required String value,
    required String label,
  }) = _StatMetricModel;
  factory StatMetricModel.fromJson(Map<String, dynamic> json) =>
      _$StatMetricModelFromJson(json);
  StatMetric toEntity() => StatMetric(value: value, label: label);
}

@freezed
sealed class SkillGroupModel with _$SkillGroupModel {
  const SkillGroupModel._();
  const factory SkillGroupModel({
    required String label,
    @Default(<String>[]) List<String> skills,
  }) = _SkillGroupModel;
  factory SkillGroupModel.fromJson(Map<String, dynamic> json) =>
      _$SkillGroupModelFromJson(json);
  SkillGroup toEntity() => SkillGroup(label: label, skills: skills);
}

@freezed
sealed class ExperienceItemModel with _$ExperienceItemModel {
  const ExperienceItemModel._();
  const factory ExperienceItemModel({
    required String role,
    required String company,
    required String location,
    required String period,
    @Default(<String>[]) List<String> bullets,
  }) = _ExperienceItemModel;
  factory ExperienceItemModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceItemModelFromJson(json);
  ExperienceItem toEntity() => ExperienceItem(
    role: role,
    company: company,
    location: location,
    period: period,
    bullets: bullets,
  );
}

@freezed
sealed class EducationItemModel with _$EducationItemModel {
  const EducationItemModel._();
  const factory EducationItemModel({
    required String degree,
    required String institution,
    required String period,
    required String grade,
  }) = _EducationItemModel;
  factory EducationItemModel.fromJson(Map<String, dynamic> json) =>
      _$EducationItemModelFromJson(json);
  EducationItem toEntity() => EducationItem(
    degree: degree,
    institution: institution,
    period: period,
    grade: grade,
  );
}

/// Data model for `profile.json` (plan.md §6.4).
@freezed
sealed class ProfileModel with _$ProfileModel {
  const ProfileModel._();
  const factory ProfileModel({
    required String name,
    required String title,
    required String location,
    required String email,
    required String phone,
    required String summary,
    @Default(<LanguageModel>[]) List<LanguageModel> languages,
    @Default(<SocialLinkModel>[]) List<SocialLinkModel> socials,
    @Default(<StatMetricModel>[]) List<StatMetricModel> stats,
    @Default(<SkillGroupModel>[]) List<SkillGroupModel> skillGroups,
    @Default(<ExperienceItemModel>[]) List<ExperienceItemModel> experience,
    @Default(<EducationItemModel>[]) List<EducationItemModel> education,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  /// Maps to the domain [Profile].
  Profile toEntity() => Profile(
    name: name,
    title: title,
    location: location,
    email: email,
    phone: phone,
    summary: summary,
    languages: languages.map((e) => e.toEntity()).toList(),
    socials: socials.map((e) => e.toEntity()).toList(),
    stats: stats.map((e) => e.toEntity()).toList(),
    skillGroups: skillGroups.map((e) => e.toEntity()).toList(),
    experience: experience.map((e) => e.toEntity()).toList(),
    education: education.map((e) => e.toEntity()).toList(),
  );
}
