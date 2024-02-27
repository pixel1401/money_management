
class User {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? scope;
  String? authuser;
  String? prompt;

  User(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.scope,
      this.authuser,
      this.prompt});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    authuser = json['authuser'];
    prompt = json['prompt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['scope'] = this.scope;
    data['authuser'] = this.authuser;
    data['prompt'] = this.prompt;
    return data;
  }
}