import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button(action: {
                    button.action()
                }, label: {
                    Text(button.title)
                })
            }
        }
        .padding()
    }
}

struct ButtonInfo: Identifiable {
    var id: UUID = .init()
    var title: String
    var action: () -> Void
}

final class ButtonInfoList {
    static let buttonList: [ButtonInfo] = [
        .init(title: "GET", action: {
            
        }),
        .init(title: "POST", action: {
            
        }),
        .init(title: "PATCH", action: {
            
        }),
        .init(title: "PUT", action: {
            
        }),
        .init(title: "DELETE", action: {
            
        }),
    ]
}

#Preview {
    ContentView()
}

