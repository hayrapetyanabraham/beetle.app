class Authorization {
  String accessToken;
  String refreshToken;
  String identifier;
  String tokenType;
  String scope;
  bool isRegistered;
  bool isEmailSent;

  Authorization(
      {this.accessToken,
      this.refreshToken,
      this.identifier,
      this.tokenType,
      this.scope,
      this.isRegistered,
      this.isEmailSent});

  factory Authorization.fromMap(Map<String, dynamic> json) => Authorization(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        identifier: json["identifier"],
        tokenType: json["tokenType"],
        scope: json["scope"],
        isRegistered: json["isRegistered"],
        isEmailSent: json["isEmailSent"],
      );

  Map<String, dynamic> toMap() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "identifier": identifier,
        "tokenType": tokenType,
        "scope": scope,
        "isRegistered": isRegistered,
        "isEmailSent": isEmailSent,
      };
}
