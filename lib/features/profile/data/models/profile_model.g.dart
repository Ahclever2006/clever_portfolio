// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) =>
    _LanguageModel(
      name: json['name'] as String,
      level: json['level'] as String,
    );

Map<String, dynamic> _$LanguageModelToJson(_LanguageModel instance) =>
    <String, dynamic>{'name': instance.name, 'level': instance.level};

_SocialLinkModel _$SocialLinkModelFromJson(Map<String, dynamic> json) =>
    _SocialLinkModel(
      label: json['label'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$SocialLinkModelToJson(_SocialLinkModel instance) =>
    <String, dynamic>{'label': instance.label, 'url': instance.url};

_StatMetricModel _$StatMetricModelFromJson(Map<String, dynamic> json) =>
    _StatMetricModel(
      value: json['value'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$StatMetricModelToJson(_StatMetricModel instance) =>
    <String, dynamic>{'value': instance.value, 'label': instance.label};

_SkillGroupModel _$SkillGroupModelFromJson(Map<String, dynamic> json) =>
    _SkillGroupModel(
      label: json['label'] as String,
      skills:
          (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$SkillGroupModelToJson(_SkillGroupModel instance) =>
    <String, dynamic>{'label': instance.label, 'skills': instance.skills};

_ExperienceItemModel _$ExperienceItemModelFromJson(Map<String, dynamic> json) =>
    _ExperienceItemModel(
      role: json['role'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      period: json['period'] as String,
      bullets:
          (json['bullets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ExperienceItemModelToJson(
  _ExperienceItemModel instance,
) => <String, dynamic>{
  'role': instance.role,
  'company': instance.company,
  'location': instance.location,
  'period': instance.period,
  'bullets': instance.bullets,
};

_EducationItemModel _$EducationItemModelFromJson(Map<String, dynamic> json) =>
    _EducationItemModel(
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      period: json['period'] as String,
      grade: json['grade'] as String,
    );

Map<String, dynamic> _$EducationItemModelToJson(_EducationItemModel instance) =>
    <String, dynamic>{
      'degree': instance.degree,
      'institution': instance.institution,
      'period': instance.period,
      'grade': instance.grade,
    };

_ProfileModel _$ProfileModelFromJson(
  Map<String, dynamic> json,
) => _ProfileModel(
  name: json['name'] as String,
  title: json['title'] as String,
  location: json['location'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  summary: json['summary'] as String,
  languages:
      (json['languages'] as List<dynamic>?)
          ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LanguageModel>[],
  socials:
      (json['socials'] as List<dynamic>?)
          ?.map((e) => SocialLinkModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SocialLinkModel>[],
  stats:
      (json['stats'] as List<dynamic>?)
          ?.map((e) => StatMetricModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StatMetricModel>[],
  skillGroups:
      (json['skillGroups'] as List<dynamic>?)
          ?.map((e) => SkillGroupModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SkillGroupModel>[],
  experience:
      (json['experience'] as List<dynamic>?)
          ?.map((e) => ExperienceItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ExperienceItemModel>[],
  education:
      (json['education'] as List<dynamic>?)
          ?.map((e) => EducationItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EducationItemModel>[],
);

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'location': instance.location,
      'email': instance.email,
      'phone': instance.phone,
      'summary': instance.summary,
      'languages': instance.languages,
      'socials': instance.socials,
      'stats': instance.stats,
      'skillGroups': instance.skillGroups,
      'experience': instance.experience,
      'education': instance.education,
    };
