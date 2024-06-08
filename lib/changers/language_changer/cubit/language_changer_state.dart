part of 'language_changer_cubit.dart';


class LanguageChangerState extends Equatable {
  final Locale locale;
  final BuildContext? context; // Make context nullable

  const LanguageChangerState(this.locale, {this.context});

  @override
  List<Object?> get props => [locale, context]; // Include context in props and make it nullable
}