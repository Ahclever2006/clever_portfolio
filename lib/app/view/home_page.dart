import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/back_to_top_button.dart';
import 'package:clever_portfolio/core/widgets/motion_background.dart';
import 'package:clever_portfolio/core/widgets/page_scroll.dart';
import 'package:clever_portfolio/features/contact/presentation/widgets/contact_section.dart';
import 'package:clever_portfolio/features/profile/presentation/widgets/about_section.dart';
import 'package:clever_portfolio/features/profile/presentation/widgets/education_section.dart';
import 'package:clever_portfolio/features/profile/presentation/widgets/experience_section.dart';
import 'package:clever_portfolio/features/profile/presentation/widgets/hero_section.dart';
import 'package:clever_portfolio/features/profile/presentation/widgets/skills_section.dart';
import 'package:clever_portfolio/features/profile/presentation/widgets/stats_band.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/featured_section.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/index_section.dart';
import 'package:clever_portfolio/shared/navigation/cubit/navigation_cubit.dart';
import 'package:clever_portfolio/shared/navigation/section_id.dart';
import 'package:clever_portfolio/shared/navigation/widgets/footer_section.dart';
import 'package:clever_portfolio/shared/navigation/widgets/glass_navbar.dart';
import 'package:clever_portfolio/shared/navigation/widgets/mobile_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The single-page host (route `/`): the full long-scroll portfolio.
class HomePage extends StatefulWidget {
  /// Creates the home page.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final Map<SectionId, GlobalKey> _keys = {
    for (final id in SectionId.values) id: GlobalKey(),
  };

  bool _showBackToTop = false;

  // Scroll offset at which the scroll-spy last walked the section keys; the spy
  // is the expensive part of _onScroll (a localToGlobal per section) so it is
  // throttled to run only every [_spyStride] px instead of every sub-pixel tick.
  double _lastSpyOffset = -1e9;
  static const double _spyStride = 24;

  static const Duration _scrollDuration = Duration(milliseconds: 600);
  static const Curve _scrollCurve = Curves.easeOutCubic;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    final offset = _scroll.offset;
    // Cheap, per-tick: both setters dedupe their emits internally.
    context.read<NavigationCubit>().setElevated(value: offset > 24);
    final show = offset > 600;
    if (show != _showBackToTop) setState(() => _showBackToTop = show);
    // Expensive (9 localToGlobal walks): throttle to every _spyStride px.
    if ((offset - _lastSpyOffset).abs() < _spyStride) return;
    _lastSpyOffset = offset;
    _updateActiveSection();
  }

  // Scroll-spy: the active section is the last one whose top has passed just
  // below the navbar.
  void _updateActiveSection() {
    const threshold = 120.0;
    SectionId? current;
    for (final id in SectionId.values) {
      final ctx = _keys[id]?.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject();
      if (box is! RenderBox || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= threshold) current = id;
    }
    if (current != null) context.read<NavigationCubit>().setActive(current);
  }

  Future<void> _scrollTo(SectionId id) async {
    final target = _keys[id]?.currentContext;
    if (target == null) return;
    context.read<NavigationCubit>().setActive(id);
    await Scrollable.ensureVisible(
      target,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  void _backToTop() =>
      _scroll.animateTo(0, duration: _scrollDuration, curve: _scrollCurve);

  Widget _anchor(SectionId id, Widget child) =>
      KeyedSubtree(key: _keys[id], child: child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MobileNavDrawer(onNavTap: _scrollTo),
      body: Stack(
        children: [
          // RepaintBoundary isolates the (animated) background into its own
          // compositing layer so its repaints don't re-record the siblings.
          const Positioned.fill(
            child: RepaintBoundary(
              child: IgnorePointer(child: MotionBackground()),
            ),
          ),
          SingleChildScrollView(
            controller: _scroll,
            child: PageScroll(
              controller: _scroll,
              child: Column(
                children: [
                  SizedBox(
                    height: context.responsive(mobile: 64.0, desktop: 72.0),
                  ),
                  _anchor(
                    SectionId.hero,
                    HeroSection(onViewWork: () => _scrollTo(SectionId.work)),
                  ),
                  _anchor(SectionId.stats, const StatsBand()),
                  _anchor(SectionId.about, const AboutSection()),
                  _anchor(SectionId.skills, const SkillsSection()),
                  _anchor(SectionId.work, const IndexSection()),
                  _anchor(SectionId.featured, const FeaturedSection()),
                  _anchor(SectionId.experience, const ExperienceSection()),
                  _anchor(SectionId.education, const EducationSection()),
                  _anchor(SectionId.contact, const ContactSection()),
                  const FooterSection(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: RepaintBoundary(
              child: GlassNavBar(
                onNavTap: _scrollTo,
                onMenu: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
          PositionedDirectional(
            end: context.spacing.lg.w,
            bottom: context.spacing.lg.h,
            child: RepaintBoundary(
              child: BackToTopButton(
                visible: _showBackToTop,
                onTap: _backToTop,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
