import SwiftUI
import WebKit

struct BottomMenuView: View {
    @State private var selectedTab = 0
    @State private var isShowingDrawer = false
    
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
                            .padding()
                    }
                    
                    Spacer()
                }
                .background(Color(.systemBackground))
                
                // WebView for the selected URL
                WebView(url: URL(string: urls[selectedTab])!)
                    .edgesIgnoringSafeArea(.top)
                
                // Bottom Tab Bar
                HStack(spacing: 0) {
                    ForEach(0..<urls.count, id: \.self) { index in
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
            
            // Side Drawer
            SideDrawerView(isShowing: $isShowingDrawer)
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
