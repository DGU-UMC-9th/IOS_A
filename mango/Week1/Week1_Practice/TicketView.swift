import SwiftUI

struct TicketView: View {
    var body: some View {
        ZStack{
            Image(.background)
                .resizable()
                .frame(width: 365, height: 366)
                .overlay(
                    Color.black.opacity(0.3)
                )
            
            VStack{
                Spacer().frame(height: 111)
                mainTitleGroup
                Spacer().frame(height: 138)
                mainBottomGroup
                Spacer().frame(height:17)
            }
        }
        .padding()
    }
    
    // 상단 Title VStack
    private var mainTitleGroup: some View{
        VStack{
            Group{
                Text("마이펫의 이중생활2")
                    .font(.PretendardBold30,)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y:4)
                Text("본인 + 동반 1인")
                    .font(.PretendarRegular16)
                Text("30,100원")
                    .font(.PretendarBold24)
            }
            .foregroundStyle(Color.white)
        }
        .frame(height:84)
    }
    
    private var mainBottomGroup: some View{
        Button(action:{
            print("안넝")
        }, label:{
            VStack{
                Image(systemName: "chevron.up").resizable().frame(width: 18, height: 12)
                    .foregroundStyle(Color.white)
                Text("예매하기")
                    .font(.PretendarSemiBold18)
                    .foregroundStyle(Color.white)
            }
            .frame(width:63, height:40)
        })
    }
}

#Preview {
    TicketView()
}
