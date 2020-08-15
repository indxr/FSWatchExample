//
//  ContentView.swift
//  FSWatch
//
//  Created by Danny Hawkins on 15/08/2020.
//

import SwiftUI
import EonilFSEvents

struct ContentView: View {
    @State var files = [String]()
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<files.count, id: \.self) { index in
                    Text(files[index])
                }
            }
        }
        .padding()
        .frame(width: 1000, height: 600)
        .onReceive(NotificationCenter.default.publisher(for: .filesChanged)) { event in
            if let fileEvent = event.object as? EonilFSEventsEvent  {
                files.insert("\(fileEvent.flag) \(fileEvent.path)", at: 0)
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
