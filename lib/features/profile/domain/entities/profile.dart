import 'package:equatable/equatable.dart';

/// The person — the single CV aggregate (plan.md §6.4). Owns experience,
/// education, skills, languages, stats, and contact fields.
class Profile extends Equatable {
  /// Creates a [Profile].
  const Profile({
    required this.name,
    required this.title,
    required this.location,
    required this.email,
    required this.phone,
    required this.summary,
    required this.languages,
    required this.socials,
    required this.stats,
    required this.skillGroups,
    required this.experience,
    required this.education,
  });

  /// Full name.
  final String name;

  /// Professional title.
  final String title;

  /// Location.
  final String location;

  /// Contact email.
  final String email;

  /// Contact phone (E.164-ish).
  final String phone;

  /// Short bio.
  final String summary;

  /// Spoken languages.
  final List<Language> languages;

  /// External profile links.
  final List<SocialLink> socials;

  /// Headline metrics.
  final List<StatMetric> stats;

  /// Grouped skills.
  final List<SkillGroup> skillGroups;

  /// Work history.
  final List<ExperienceItem> experience;

  /// Education history.
  final List<EducationItem> education;

  @override
  List<Object?> get props => [
    name,
    title,
    location,
    email,
    phone,
    summary,
    languages,
    socials,
    stats,
    skillGroups,
    experience,
    education,
  ];
}

/// A spoken language and proficiency.
class Language extends Equatable {
  /// Creates a [Language].
  const Language({required this.name, required this.level});

  /// Language name.
  final String name;

  /// Proficiency (e.g. "Native", "Fluent").
  final String level;

  @override
  List<Object?> get props => [name, level];
}

/// An external profile link (GitHub, etc.).
class SocialLink extends Equatable {
  /// Creates a [SocialLink].
  const SocialLink({required this.label, required this.url});

  /// Display label.
  final String label;

  /// Target URL.
  final String url;

  @override
  List<Object?> get props => [label, url];
}

/// A headline count-up metric (e.g. 37 Published Apps).
class StatMetric extends Equatable {
  /// Creates a [StatMetric].
  const StatMetric({required this.value, required this.label});

  /// The number/label (e.g. "37", "5+").
  final String value;

  /// What it counts.
  final String label;

  @override
  List<Object?> get props => [value, label];
}

/// A labelled group of skills.
class SkillGroup extends Equatable {
  /// Creates a [SkillGroup].
  const SkillGroup({required this.label, required this.skills});

  /// Group label.
  final String label;

  /// Skills in the group.
  final List<String> skills;

  @override
  List<Object?> get props => [label, skills];
}

/// A role in the work history.
class ExperienceItem extends Equatable {
  /// Creates an [ExperienceItem].
  const ExperienceItem({
    required this.role,
    required this.company,
    required this.location,
    required this.period,
    required this.bullets,
  });

  /// Job title.
  final String role;

  /// Employer.
  final String company;

  /// Location.
  final String location;

  /// Date range.
  final String period;

  /// Outcome bullets.
  final List<String> bullets;

  @override
  List<Object?> get props => [role, company, location, period, bullets];
}

/// An education entry.
class EducationItem extends Equatable {
  /// Creates an [EducationItem].
  const EducationItem({
    required this.degree,
    required this.institution,
    required this.period,
    required this.grade,
  });

  /// Degree.
  final String degree;

  /// Institution.
  final String institution;

  /// Date range.
  final String period;

  /// Grade.
  final String grade;

  @override
  List<Object?> get props => [degree, institution, period, grade];
}
