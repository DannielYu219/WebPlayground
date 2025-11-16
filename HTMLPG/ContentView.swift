//
//  ContentView.swift
//  HTMLPG
//
//  Created by Daniel www on 2025/1/29.
//

import SwiftUI
import Photos

struct DeviceInfo {
    // 物理屏幕尺寸（单位：点）
    static var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    // 实际像素分辨率（考虑缩放因子）
    static var nativeSize: CGSize {
        UIScreen.main.nativeBounds.size
    }
    
    // 屏幕缩放比例
    static var scale: CGFloat {
        UIScreen.main.scale
    }
    
    // 当前窗口尺寸（iOS 16+）
    static var windowSize: CGSize? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.screen.bounds.size
    }
}

struct ContentView: View {
    
    //@State private var htmlContent:
    
    @AppStorage("Data") var htmlContent: String = """
        <html>
            <body>
                <h1>Welcome to HTML Viewer</h1>
                <p>Select an HTML file to view its content.</p>
            </body>
        </html>
    """
    
    @AppStorage("Set") var setting = "FullScreen"
    
    @State private var isShowingDocumentPicker1 = false
    @State var box = 0
    
    @State private var showCopyAlert = false
    @State private var alertMessage = ""
    
    @State var High: Array = [CGFloat(0.5625), CGFloat(1.7778), CGFloat(1.5),CGFloat(0.6667),]
    
    let show = ["16:9","9:16","2:3","3:2","FullScreen"]
    
    let device = UIDevice.current
    
    @State var URLMODE = false
    
    var body: some View {
        ZStack{
            if box == 0{
                VStack {
                    HStack{
                        Text("Click To Enter")
                            .font(.system(.title2, weight: .ultraLight))
                        Button(action:{
                            self.box = 3
                        }){
                            Image(systemName: "gear")
                                .frame(width: 32, height: 32)
                                .padding(.horizontal,20)
                        }
                    }
                    Button(action:{
                        self.box = 1
                    }){
                        ZStack {
                            Rectangle()
                                .fill(.clear)
                                .background(Material.regular)
                                .frame(width: 256, height: 192)
                                .clipped()
                                .mask { RoundedRectangle(cornerRadius: 24, style: .continuous) }
                                .padding(24)
                            Text("HTML")
                                .font(.system(size: 50, weight: .thin, design: .rounded))
                        }
                    }
                    Button(action:{
                        self.box = 2
                    }){
                        ZStack {
                            Rectangle()
                                .fill(.clear)
                                .background(Material.regular)
                                .frame(width: 256, height: 192)
                                .clipped()
                                .mask { RoundedRectangle(cornerRadius: 24, style: .continuous) }
                                .padding(24)
                            Text("EDIT")
                                .font(.system(size: 50, weight: .thin, design: .rounded))
                        }
                    }
                }
            }
            if box == 1{
                ZStack {
                    // WebView to display HTML content
                    if URLMODE == false{
                        if setting == "FullScreen"{
                            WebView(htmlString: htmlContent)
                                .edgesIgnoringSafeArea(.all)
                                .statusBarHidden(true)
                                .padding(.all,-3)
                        }else{
                            ZStack{
                                Rectangle()
                                    .fill(Color.black)
                                    .edgesIgnoringSafeArea(.all)
                                    .statusBarHidden(true)
                                if setting == "16:9"{
                                    WebView(htmlString: htmlContent)
                                        .frame(width: DeviceInfo.windowSize?.width, height: (DeviceInfo.windowSize?.width ?? 0) / 16 * 9)
                                }
                                if setting == "9:16"{
                                    WebView(htmlString: htmlContent)
                                        .frame(width: DeviceInfo.windowSize?.width, height: (DeviceInfo.windowSize?.width ?? 0) / 9 * 16)
                                }
                                if setting == "3:2"{
                                    WebView(htmlString: htmlContent)
                                        .frame(width: DeviceInfo.windowSize?.width, height: (DeviceInfo.windowSize?.width ?? 0) / 3 * 2)
                                }
                                if setting == "2:3"{
                                    WebView(htmlString: htmlContent)
                                        .frame(width: DeviceInfo.windowSize?.width, height: (DeviceInfo.windowSize?.width ?? 0) / 2 * 3)
                                }
                            }
                        }
                        // Button to open document picker
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    self.box = 3
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "gear")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical)
                                Button(action: {
                                    self.box = 2
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical)
                                Button(action: {
                                    isShowingDocumentPicker1 = true
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.trailing)
                                .padding(.vertical)
                            }
                            
                        }
                        .frame(width: DeviceInfo.screenSize.width, height: DeviceInfo.screenSize.height)
                    }else{
                        if setting == "FullScreen"{
                            URLWebView(url: URL(string: htmlContent)!)
                                .edgesIgnoringSafeArea(.all)
                                .statusBarHidden(true)
                                .padding(.all,-3)
                        }else{
                            ZStack{
                                Rectangle()
                                    .fill(Color.black)
                                    .edgesIgnoringSafeArea(.all)
                                    .statusBarHidden(true)
                                if setting == "16:9"{
                                    URLWebView(url: URL(string: htmlContent)!)
                                        .frame(width: DeviceInfo.windowSize?.width, height: (DeviceInfo.windowSize?.width ?? 0) / 16 * 9)
                                }
                                if setting == "9:16"{
                                    URLWebView(url: URL(string: htmlContent)!)
                                        .frame(width: DeviceInfo.windowSize?.width, height: (DeviceInfo.windowSize?.width ?? 0) / 9 * 16)
                                }
                                if setting == "3:2"{
                                    URLWebView(url: URL(string: htmlContent)!)
                                        .frame(width: DeviceInfo.windowSize?.width, height: (DeviceInfo.windowSize?.width ?? 0) / 3 * 2)
                                }
                                if setting == "2:3"{
                                    URLWebView(url: URL(string: htmlContent) ?? URL(string: "about:blank")!)
                                        .frame(width: DeviceInfo.windowSize?.width, height: (DeviceInfo.windowSize?.width ?? 0) / 2 * 3)
                                }
                            }
                        }
                        // Button to open document picker
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    self.box = 3
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "gear")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical)
                                Button(action: {
                                    self.box = 2
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical)
                                .padding(.trailing)
                            }
                            
                        }
                        .frame(width: DeviceInfo.screenSize.width, height: DeviceInfo.screenSize.height)
                    }
                }
                .frame(width: DeviceInfo.screenSize.width, height: DeviceInfo.screenSize.height)
                .sheet(isPresented: $isShowingDocumentPicker1) {
                    DocumentPicker1(fileContent: $htmlContent)
                }
            }
            if box == 2{
                // 在 ContentView 中调用
                ZStack{
                    if device.userInterfaceIdiom == .phone {
                        TextEditor(text: $htmlContent)
                            .alert("Note", isPresented: $showCopyAlert) {
                                Button("OK") { }
                            } message: {
                                Text(alertMessage)
                            }
                            .padding(.vertical,110)
                    } else {
                        TextEditor(text: $htmlContent)
                            .alert("Note", isPresented: $showCopyAlert) {
                                Button("OK") { }
                            } message: {
                                Text(alertMessage)
                            }
                    }
                    VStack{
                        if device.userInterfaceIdiom == .phone {
                            HStack{
                                Button(action: {
                                    if htmlContent == """
                                        <html>
                                            <body>
                                                <h1>Welcome to HTML Viewer</h1>
                                                <p>Select an HTML file to view its content.</p>
                                            </body>
                                        </html>
                                    """{
                                        self.htmlContent = """
                                    """
                                    }else{
                                        self.htmlContent = """
                                            <html>
                                                <body>
                                                    <h1>Welcome to HTML Viewer</h1>
                                                    <p>Select an HTML file to view its content.</p>
                                                </body>
                                            </html>
                                        """
                                    }
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        if htmlContent == """
                                            <html>
                                                <body>
                                                    <h1>Welcome to HTML Viewer</h1>
                                                    <p>Select an HTML file to view its content.</p>
                                                </body>
                                            </html>
                                        """{
                                            Image(systemName: "trash")
                                                .foregroundColor(.white)
                                        }else{
                                            Image(systemName: "arrow.clockwise")
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding(.vertical,25)
                                .padding(.leading)
                                Button(action:{
                                    
                                }){
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "doc.on.doc")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical,25)
                                Button(action: {
                                    self.box = 1
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "eye.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical,25)
                                Spacer()
                                ZStack {
                                    Rectangle()
                                        .fill(.clear)
                                        .background(Material.ultraThin)
                                        .frame(width: 120, height: 40)
                                        .clipped()
                                        .mask { RoundedRectangle(cornerRadius: 35, style: .continuous) }
                                    Rectangle()
                                        .fill(.clear)
                                        .background(Material.ultraThin)
                                        .frame(width: 112, height: 32)
                                        .clipped()
                                        .mask { RoundedRectangle(cornerRadius: 28, style: .continuous) }
                                }
                                .padding(.trailing)
                            }
                            .padding(.top,32)
                            Spacer()
                        }else{
                            Spacer()
                            HStack{
                                Button(action: {
                                    if htmlContent == """
                                        <html>
                                            <body>
                                                <h1>Welcome to HTML Viewer</h1>
                                                <p>Select an HTML file to view its content.</p>
                                            </body>
                                        </html>
                                    """{
                                        self.htmlContent = """
                                    """
                                    }else{
                                        self.htmlContent = """
                                            <html>
                                                <body>
                                                    <h1>Welcome to HTML Viewer</h1>
                                                    <p>Select an HTML file to view its content.</p>
                                                </body>
                                            </html>
                                        """
                                    }
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        if htmlContent == """
                                            <html>
                                                <body>
                                                    <h1>Welcome to HTML Viewer</h1>
                                                    <p>Select an HTML file to view its content.</p>
                                                </body>
                                            </html>
                                        """{
                                            Image(systemName: "trash")
                                                .foregroundColor(.white)
                                        }else{
                                            Image(systemName: "arrow.clockwise")
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding(.vertical,25)
                                .padding(.leading)
                                Button(action:{
                                    
                                }){
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "doc.on.doc")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical,25)
                                Button(action: {
                                    self.box = 1
                                }) {
                                    ZStack{
                                        Circle()
                                            .frame(width: 40,height: 40)
                                        Image(systemName: "eye.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical,25)
                                Spacer()
                                ZStack {
                                    Rectangle()
                                        .fill(.clear)
                                        .background(Material.ultraThin)
                                        .frame(width: 160, height: 40)
                                        .clipped()
                                        .mask { RoundedRectangle(cornerRadius: 35, style: .continuous) }
                                    Rectangle()
                                        .fill(.clear)
                                        .background(Material.ultraThin)
                                        .frame(width: 152, height: 32)
                                        .clipped()
                                        .mask { RoundedRectangle(cornerRadius: 28, style: .continuous) }
                                    ZStack{
                                        HStack{
                                            Text("URL Mode")
                                                .padding(.horizontal,8)
                                            Spacer()
                                        }
                                        .frame(width: 148, height: 32)
                                        Toggle("", isOn: $URLMODE)
                                            .frame(width: 148, height: 32)
                                    }
                                }
                                .padding(.trailing)
                            }
                        }
                    }
                }
            }
            if box == 3{
                ZStack{
                    Picker("Choose the display ratio", selection: $setting){
                        ForEach(show, id: \.self){ sh in
                            Text(sh)
                        }
                    }
                    .pickerStyle(.wheel)
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Button(action: {
                                self.box = 1
                            }) {
                                ZStack{
                                    Circle()
                                        .frame(width: 40,height: 40)
                                    Image(systemName: "eye.fill")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.all)
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBarHidden(true)
    }
    
    private func copyToClipboard() {
        guard !htmlContent.isEmpty else {
            alertMessage = "Nothing to copy"
            showCopyAlert = true
            return
        }
        
        UIPasteboard.general.string = htmlContent
        alertMessage = "Copied successful"
        showCopyAlert = true
        
        // 可选：触觉反馈
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

#Preview {
    ContentView()
}
