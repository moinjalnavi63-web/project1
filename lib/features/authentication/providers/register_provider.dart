import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RegisterState {

  final String selectedIdentity;
  final String? selectedRoute;

  final bool passwordVisible;
  final bool isLoading;


  const RegisterState({
    this.selectedIdentity = "Student",
    this.selectedRoute,
    this.passwordVisible = false,
    this.isLoading = false,
  });


  RegisterState copyWith({

    String? selectedIdentity,

    String? selectedRoute,

    bool? passwordVisible,

    bool? isLoading,

  }) {

    return RegisterState(

      selectedIdentity:
      selectedIdentity ?? this.selectedIdentity,

      selectedRoute:
      selectedRoute ?? this.selectedRoute,

      passwordVisible:
      passwordVisible ?? this.passwordVisible,

      isLoading:
      isLoading ?? this.isLoading,

    );

  }
}



class RegisterController
    extends StateNotifier<RegisterState> {


  RegisterController()
      : super(const RegisterState());



  void changeIdentity(String value){

    state = state.copyWith(
      selectedIdentity: value,
    );

  }



  void changeRoute(String? value){

    state = state.copyWith(
      selectedRoute: value,
    );

  }



  void togglePassword(){

    state = state.copyWith(
      passwordVisible:
      !state.passwordVisible,
    );

  }



  void setLoading(bool value){

    state = state.copyWith(
      isLoading: value,
    );

  }


}



final registerProvider =
StateNotifierProvider<
    RegisterController,
    RegisterState>((ref){

  return RegisterController();

});