import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  // List of allowed OTPs
  final List<String> allowedOtps = ["123456", "124589", "543254"];

  void verifyOtp(String enteredOtp) async {
    emit(OtpLoading());
    await Future.delayed(const Duration(milliseconds: 500));

    if (allowedOtps.contains(enteredOtp)) {
      emit(OtpLoaded(isVerified: true));
    } else {
      emit(OtpError("Invalid OTP, please try again"));
    }
  }
}
