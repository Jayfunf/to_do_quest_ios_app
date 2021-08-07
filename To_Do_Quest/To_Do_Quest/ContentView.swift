//
//  ContentView.swift
//  To_Do_Quest
//
//  Created by Minhyun Cho on 2021/07/27.
//

import SwiftUI
import RxCocoa
import RxSwift

struct ContentView: View {
    @State private var selection = 0 //R
    
    var body: some View {
        VStack{
            TabView(selection: $selection){ //R
                Text("list").tag(0)
                Text("NPC").tag(1)
                Text("setting").tag(2)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            Divider()
            TabBar(selection: $selection)
        }
    }
}
struct TabBar: View {
    @Binding var selection: Int
    @Namespace private var currentTab
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(tabs.indices) { index in
                // 실선을 표시하기 위한 GeometryReader
                GeometryReader { geometry in
                    VStack(spacing: 4) {
                        if selection == index {
                            // 현재 선택된 탭 바 메뉴 색상 설정
                            Color(red: 0 / 255, green: 122 / 255, blue: 255 / 255)
                                .frame(height: 2)
                                .offset(y: -8)
                                .matchedGeometryEffect(id: "currentTab", in: currentTab)
                        }
                        // 이미지 설정
                        Image(tabs[index].image)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                        Text(tabs[index].text)
                            .padding()
                            
                    }
                    // 아이콘이 선택되지 않았다면 작게, 선택됐다면 크게 설정한다. 선택될 때마다 이미지 크기가 커짐
                    .frame(width: geometry.size.width / 2,
                           height: selection == index ? 40 : 30,
                           alignment: .center)
                    .padding(.horizontal)
                    .foregroundColor(selection == index ? Color(red: 0 / 255, green: 122 / 255, blue: 255 / 255) : Color(red: 211 / 255, green: 211 / 255, blue: 211 / 255))
                    // 해당 이미지가 선택됐을 때, 어떤 동작을 할 것인지 구현할 수 있다.
                    .onTapGesture {
                        // selection 변수의 값을 업데이트한다.
                        withAnimation {
                            selection = index
                        }
                    }
                }
                .frame(height: 44, alignment: .bottom)
            }
        }
    }
}

struct Tab {
    let image: String
    let label: String
    let text: String
}

let tabs: [Tab] = [
    Tab(image: "list", label: "list", text:"list"),
    Tab(image: "NPC", label: "NPC", text: "NPC"),
    Tab(image: "setting", label: "setting", text: "setting"),
]
//https://blog.naver.com/auburn0820/222302764923

struct ContentView_Previews: PreviewProvider { //ContentView 미리보기용. 건들지 말자.
    static var previews: some View {
        ContentView()
    }
}
