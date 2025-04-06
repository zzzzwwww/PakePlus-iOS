import SwiftUI
import WebKit

struct BottomMenuView: View {
    @State private var selectedTab = 0
    @State private var isShowingDrawer = false
    @State private var isShowingMenu = false
    
    // Define your URLs here
    private let urls = [
        "https://www.baidu.com/",
        "https://juejin.cn/",
        "https://chat.deepseek.com/"
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Top Bar with Menu Button
                HStack {
                    Button(action: {
                        isShowingDrawer = true
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Text("PakePlus")
                    
                    Spacer()
                    
                    // 自定义菜单按钮
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isShowingMenu.toggle()
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .background(Color(.systemBackground))
                .padding(.horizontal)
                .padding(.vertical, 6)
                
                // WebView for the selected URL
                WebView(url: URL(string: urls[selectedTab])!)
                    .edgesIgnoringSafeArea(.top)
                
                // Bottom Tab Bar
                HStack(spacing: 0) {
                    ForEach(0 ..< urls.count, id: \.self) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            VStack {
                                Image(systemName: tabIcon(for: index))
                                    .font(.system(size: 20))
                                Text(tabTitle(for: index))
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                        }
                    }
                }
                .background(Color(.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.systemGray4)),
                    alignment: .top
                )
            }
            
            // 自定义菜单
            if isShowingMenu {
                VStack(alignment: .trailing, spacing: 0) {
                    Button(action: {
                        // 复制网址动作
                        isShowingMenu = false
                    }) {
                        Text("复制网址")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .frame(width: 100)
                    }
                    .background(Color(.systemBackground))
                    
                    Button(action: {
                        // 外部打开动作
                        isShowingMenu = false
                    }) {
                        Text("外部打开")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .frame(width: 100)
                    }
                    .background(Color(.systemBackground))
                    
                    Button(action: {
                        // 重新加载动作
                        isShowingMenu = false
                    }) {
                        Text("重新加载")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .frame(width: 100)
                    }
                    .background(Color(.systemBackground))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 0.5)
                )
                .position(x: UIScreen.main.bounds.width - 60, y: 90)
                .transition(.opacity)
            }
            
            // Side Drawer
            SideDrawerView(isShowing: $isShowingDrawer)
        }
        .onTapGesture {
            if isShowingMenu {
                withAnimation(.easeInOut) {
                    isShowingMenu = false
                }
            }
        }
    }
    
    private func tabIcon(for index: Int) -> String {
        switch index {
        case 0:
            return "house.fill"
        case 1:
            return "star.fill"
        case 2:
            return "play.fill"
        default:
            return "circle.fill"
        }
    }
    
    private func tabTitle(for index: Int) -> String {
        switch index {
        case 0:
            return "Home"
        case 1:
            return "Favorites"
        case 2:
            return "Videos"
        default:
            return "Tab"
        }
    }
}

#Preview {
    BottomMenuView()
}
