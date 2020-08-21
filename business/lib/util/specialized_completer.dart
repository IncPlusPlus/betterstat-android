import 'dart:async';

/// A special two-tuple that contains two `Completer`s. I created this class
/// because I wanted to be able to use a RefreshIndicator that lasted until
/// the relevant refreshing action was complete. I was able to do this but with a catch,
/// I had to smuggle a Completer<void> as a type parameter of the refreshing action
/// and the middleware always had to call `completer.complete()` on it regardless of
/// whether it was completed successfully. I considered simply calling an `actionSuccess` and
/// `actionFailure` action from the middleware and then passing [completerStatus] as the payload for them.
/// However, I think this might violate the purity of the reducers that receive those which is a design no-no.
/// When I tried sending back any errors using `completer.completeError()`, Flutter always complained about
/// unhandled exceptions despite the fact that I was catching the errors and processing them properly.
/// I narrowed this down to the fact that the `Future` that was being passed to RefreshIndicator's
/// `onRefresh` function. Because the future that was passed to RefreshIndicator was completed with an error,
/// it counted as being unhandled. I'd like to avoid doing that so here I am. If there's a better way to do this,
/// PLEASE LET ME KNOW. This solution is way too jank for my liking.
///
/// You can return the [completer]'s `Future` to a RefreshIndicator's `onRefresh`
/// function and use [statusCompleter] for propagating an error back from
/// your middleware. This means that you should have an action that contains
/// a [SpecializedCompleterTuple] as mentioned in [brianegan/flutter_redux#6](https://github.com/brianegan/flutter_redux/issues/6#issuecomment-365720043).
///
/// Within your middleware that intercepts this action and performs the async work,
/// you should call `completer.complete()` after the async task is complete to
/// let the RefreshIndicator know it's time to hide the spinner. It MUST call
/// `completer.complete()` regardless of whether the middleware failed in its task execution.
/// Your middleware must also call EITHER `statusCompleter.complete()` OR `statusCompleter.completeError()`
/// depending on whether or not you want to display an error in the UI.
///
/// By using this class, you can avoid sending futures that were completed with errors
/// outside the scope of your code (i.e. into RefreshIndicator).
class SpecializedCompleterTuple {
  final Completer<void> completer = Completer();
  final Completer<void> statusCompleter = Completer();

  SpecializedCompleterTuple();
}
