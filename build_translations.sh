#!/usr/bin/env bash

flutter pub pub run intl_translation:extract_to_arb --output-dir=./ lib/localization.dart
mv intl_messages.arb intl_en.arb
#FILES:="$(find . -name '*.arb' -print0 | xargs -0)"
flutter pub pub run intl_translation:generate_from_arb --no-use-deferred-loading lib/localization.dart "$(find . -name '*.arb' -print0 | xargs -0)"
mv messages*.dart lib/localizations