// Message model
class Message {
  const Message({
    required this.text,
    required this.fromName,
    required this.fromEmail,
    required this.timendate,
    required this.isImage,
  });

  final String text;
  final String fromName;
  final String fromEmail;
  final String timendate;
  final bool isImage;
}
