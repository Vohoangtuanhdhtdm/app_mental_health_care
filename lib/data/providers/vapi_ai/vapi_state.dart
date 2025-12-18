import 'package:equatable/equatable.dart';

class VapiState extends Equatable {
  final bool isCallActive;
  final bool isConnecting;
  final bool isSpeaking;
  final bool isCallEnded;
  final bool isMuted;
  final List<Map<String, String>> messages;

  const VapiState({
    this.isMuted = false,
    this.isCallActive = false,
    this.isConnecting = false,
    this.isSpeaking = false,
    this.isCallEnded = false,
    this.messages = const [],
  });

  // Safe update method
  VapiState copyWith({
    bool? isMuted,
    bool? isCallActive,
    bool? isConnecting,
    bool? isSpeaking,
    bool? isCallEnded,
    List<Map<String, String>>? messages,
  }) {
    return VapiState(
      isMuted: isMuted ?? this.isMuted,
      isCallActive: isCallActive ?? this.isCallActive,
      isConnecting: isConnecting ?? this.isConnecting,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      isCallEnded: isCallEnded ?? this.isCallEnded,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object> get props => [
    isCallActive,
    isConnecting,
    isSpeaking,
    isCallEnded,
    messages,
  ];
}
