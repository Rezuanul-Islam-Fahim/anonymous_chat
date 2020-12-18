class Message {
  const Message({
    this.text,
    this.fromName,
    this.fromEmail,
    this.timendate,
    this.isImage,
  });

  final String text;
  final String fromName;
  final String fromEmail;
  final String timendate;
  final bool isImage;
}
