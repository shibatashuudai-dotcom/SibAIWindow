import SwiftUI

struct ChatMessage: Identifiable {
let id = UUID()
let text: String
let isUser: Bool
}

struct ContentView: View {

@State private var isLoggedIn = false
@State private var message = ""
@State private var messages: [ChatMessage] = []
var body: some View {
    if isLoggedIn {
        chatView
    } else {
        loginView
    }
}
// ログイン画面
var loginView: some View {
    VStack(spacing: 20) {
        Text("SibAiWindow")
            .font(.largeTitle)
            .bold()
        Text("ChatGPTとつながるAIチャット")
        Button {
            // 仮のログイン処理
            isLoggedIn = true
        } label: {
            Text("ChatGPTでログイン")
                .frame(width: 200)
                .padding(10)
        }
    }
    .frame(width: 320, height: 200)
}
// チャット画面
var chatView: some View {
    VStack(spacing: 8) {
        HStack {
            Text("SibAiWindow")
                .bold()
            Spacer()
            Button("ログアウト") {
                isLoggedIn = false
            }
        }
        .padding(.horizontal, 8)
        ScrollView {
            VStack(spacing: 8) {
                ForEach(messages) { chat in
                    HStack {
                        if chat.isUser {
                            Spacer()
                        }
                        Text(chat.text)
                            .padding(8)
                        if !chat.isUser {
                            Spacer()
                        }
                    }
                }
            }
            .padding(8)
        }
        Divider()
        HStack {
            TextField("質問を入力...", text: $message)
                .textFieldStyle(.plain)
                .onSubmit {
                    sendMessage()
                }
            Button("送信") {
                sendMessage()
            }
        }
        .padding(8)
    }
    .frame(width: 320, height: 200)
}
func sendMessage() {
    if !message.isEmpty {
        messages.append(
            ChatMessage(text: message, isUser: true)
        )
        message = ""
        DispatchQueue.main.async {
            NSApp.keyWindow?.orderOut(nil)
        }
    }
}

}

#Preview {
ContentView()
}
