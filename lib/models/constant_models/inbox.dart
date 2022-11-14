class InbBox {
  int? reqId;
  String? requestDate;
  String? requestUser;
  String? requestMessage;
  String? requestTitle;
  String? gateWayCode;
  String? messageType;
  int? templateId;
  String? sendStatus;
  String? finalSendDate;
  String? finalStatusMessage;
  String? isUse;
  String? sourceType;
  String? sourceKeyRefNo;
  String? attachmentPath;
  String? receiver;

  InbBox({
    this.reqId,
    this.requestDate,
    this.requestUser,
    this.requestMessage,
    this.requestTitle,
    this.gateWayCode,
    this.messageType,
    this.templateId,
    this.sendStatus,
    this.finalSendDate,
    this.finalStatusMessage,
    this.isUse,
    this.sourceType,
    this.sourceKeyRefNo,
    this.attachmentPath,
    this.receiver,
  });

  factory InbBox.formJson(Map<String, dynamic> json) {
    return InbBox(
      reqId: json["ReqId"],
      requestDate: json["RequestDate"],
      requestUser: json["RequestUser"],
      requestMessage: json["RequestMessage"],
      requestTitle: json["RequestTitle"],
      gateWayCode: json["GateWayCode"],
      messageType: json["MessageType"],
      templateId: json["TemplateId"],
      sendStatus: json["SendStatus"],
      finalSendDate: json["FinalSendDate"],
      finalStatusMessage: json["FinalStatusMessage"],
      isUse: json["IsUse"],
      sourceType: json["SourceType"],
      sourceKeyRefNo: json["SourceKeyRefNo"],
      attachmentPath: json["AttachmentPath"],
      receiver: json["Receiver"],
    );
  }
}
