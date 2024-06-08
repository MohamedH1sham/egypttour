import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'language_changer_state.dart';

class LanguageChangerCubit extends Cubit<LanguageChangerState> {
  LanguageChangerCubit(BuildContext context)
      : super(LanguageChangerState(const Locale('en', 'US'), context: context));

  void switchLanguage() {
    final newLocale = state.locale.languageCode == 'en'
        ? const Locale('ar', 'AR')
        : const Locale('en', 'US');
    emit(LanguageChangerState(newLocale, context: state.context));
    EasyLocalization.of(state.context!)?.setLocale(newLocale);
  }

  void setContext(BuildContext context) {
    emit(LanguageChangerState(state.locale, context: context));
  }
}
