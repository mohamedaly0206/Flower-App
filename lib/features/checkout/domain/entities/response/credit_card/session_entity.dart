import 'package:equatable/equatable.dart';
import 'package:flower_app/features/checkout/domain/entities/response/credit_card/session_metadata_entity.dart';

class SessionEntity extends Equatable {
  final String? id;
  final String? cancelUrl;
  final String? clientReferenceId;
  final String? customerEmail;
  final SessionMetadataEntity? metadata;
  final String? paymentStatus;
  final String? successUrl;
  final String? url;

  const SessionEntity({
    this.id,
    this.cancelUrl,
    this.clientReferenceId,
    this.customerEmail,
    this.metadata,
    this.paymentStatus,
    this.successUrl,
    this.url,
  });

  @override
  List<Object?> get props => [
    id,
    cancelUrl,
    clientReferenceId,
    customerEmail,
    metadata,
    paymentStatus,
    successUrl,
    url,
  ];
}
