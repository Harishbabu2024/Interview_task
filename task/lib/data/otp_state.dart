part of 'otp_cubit.dart';

abstract class OtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpLoaded extends OtpState {
  final bool isVerified;
  OtpLoaded({required this.isVerified});

  @override
  List<Object?> get props => [isVerified];
}

class OtpError extends OtpState {
  final String message;
  OtpError(this.message);

  @override
  List<Object?> get props => [message];
}
