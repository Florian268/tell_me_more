class ChatModel{
  late String _llmResponse;
  late String _chatHistory;

  ChatModel(){
    _llmResponse = "";
    _chatHistory = "";
  }

  String getChatHistory() {
    return _chatHistory;
  }

  setChatHistory(String conversation) {
    _chatHistory = conversation;
  }

  void setLlmResponse(String response) {
    _llmResponse = response;
  }

  getLlmResponse() {
    return _llmResponse;
  }
}