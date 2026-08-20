sealed class OrderTrackingIntent {}

class ListenToOrderIntent extends OrderTrackingIntent {
  final String orderId;

  ListenToOrderIntent(this.orderId);
}

class MarkOrderCompletedIntent extends OrderTrackingIntent {
  final String orderId;

  MarkOrderCompletedIntent(this.orderId);
}
