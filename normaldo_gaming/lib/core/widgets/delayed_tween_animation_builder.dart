import 'package:flutter/widgets.dart';

/// Mimics the [TweenAnimationBuilder] but with an optional delay.
class DelayedTweenAnimationBuilder<T extends Object?> extends StatefulWidget {
  const DelayedTweenAnimationBuilder({
    Key? key,
    required this.tween,
    required this.duration,
    required this.builder,
    required this.delay,
    this.curve = Curves.linear,
    this.child,
    this.onEnd,
    this.delayOnlyOnce = true,
  }) : super(key: key);

  /// Defines the target value for the animation.
  ///
  /// When the widget first builds, the animation runs from [Tween.begin] to
  /// [Tween.end], if [Tween.begin] is non-null. A new animation can be
  /// triggered at anytime by providing a new [Tween] with a new [Tween.end]
  /// value. The new animation runs from the current animation value (which may
  /// be [Tween.end] of the old [tween], if that animation completed) to
  /// [Tween.end] of the new [tween]. The [Tween.begin] value is ignored except
  /// for the initial animation that is triggered when the widget builds for the
  /// first time.
  ///
  /// Any (subclass of) [Tween] is accepted as an argument. For example, to
  /// animate the height or width of a [Widget], use a [Tween<double>], or
  /// check out the [ColorTween] to animate the color property of a [Widget].
  ///
  /// Any [Tween] provided must have a non-null [Tween.end] value.
  ///
  /// ## Ownership
  ///
  /// The [DelayedTweenAnimationBuilder] takes full ownership of the provided [Tween]
  /// and it will mutate the [Tween]. Once a [Tween] instance has been passed
  /// to [DelayedTweenAnimationBuilder] its properties should not be accessed or
  /// changed anymore to avoid any interference with the
  /// [DelayedTweenAnimationBuilder]. If you need to change the [Tween], create a
  /// **new instance** with the new values.
  ///
  /// It is good practice to never store a [Tween] provided to a
  /// [DelayedTweenAnimationBuilder] in an instance variable to avoid accidental
  /// modifications of the [Tween].
  final Tween<T> tween;

  /// The duration over which to animate the parameters.
  final Duration duration;

  /// Called every time the animation value changes.
  ///
  /// The current animation value is passed to the builder along with the
  /// [child]. The builder should build a [Widget] based on the current
  /// animation value and incorporate the [child] into it, if it is non-null.
  final ValueWidgetBuilder<T> builder;

  /// The delay for which to wait before animating the changes.
  final Duration delay;

  /// The curve with which to animate the changes in [tween]
  final Curve curve;

  /// An optional static child that will be passed to [builder].
  ///
  /// Can be used to optimize rebuilds.
  final Widget? child;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final VoidCallback? onEnd;

  /// Whether to only delay the first animation when this widget is created.
  ///
  /// If this is true (default), all subsequent changes to [tween] will be
  /// animated instantly. If this is false, those changes will only start
  /// animating after [delay] as well.
  final bool delayOnlyOnce;

  @override
  createState() => _DelayedTweenAnimationBuilderState<T>();
}

// Note: Requires [StateDelay] from my './animation_mixins.dart' gist.
class _DelayedTweenAnimationBuilderState<T extends Object?>
    extends State<DelayedTweenAnimationBuilder<T>> {
  late Tween<T> _tween = widget.tween;

  late final Tween<T> _constantBeginTween = Tween(
    begin: widget.tween.begin,
    end: widget.tween.begin,
  );

  bool _delayExpired = false;

  @override
  void initState() {
    _setTween();
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tween.end != widget.tween.end) _setTween();
  }

  _setTween() => setState(() {
        _tween = _delayExpired ? widget.tween : _constantBeginTween;
        if (!_delayExpired) {
          Future.delayed(widget.delay).then(
            (_) {
              if (mounted) {
                setState(() {
                  _delayExpired = widget.delayOnlyOnce;
                  _tween = widget.tween;
                });
              }
            },
          );
        }
      });

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<T>(
        tween: _tween,
        duration: widget.duration,
        curve: widget.curve,
        builder: widget.builder,
        onEnd: widget.onEnd,
        child: widget.child,
      );
}
