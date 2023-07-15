//
//  ProBierWidget.swift
//  ProBierWidget
//
//  Created by Hans-Christian Wollert on 15.07.23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(
            date: Date(),
            url: "https://images.punkapi.com/v2/227.png",
            name: "Pilsen"
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            url: "https://images.punkapi.com/v2/227.png",
            name: "Pilsen"
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries: [SimpleEntry] = []
            do {
                let beer = try await BeerManager.shared.getRandomBeer()
                let entry = SimpleEntry(
                    date: Date(),
                    url: beer.image_url ?? "",
                    name: beer.name
                )
                entries.append(entry)
            } catch ErrorType.tooManyRequests {
                print("too many requests")
            } catch ErrorType.notAvailable {
                print("not available")
            } catch let error {
                print("Error: \(error)")
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let url: String
    let name: String
}

struct NetworkImage: View {
    
    let url: URL?
    
    var body: some View {
        
        Group {
            if let url = url, let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            else {
                Image(systemName: "bubbles.and.sparkles")
            }
        }
    }
    
}

struct ProBierWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center) {
            NetworkImage(url: URL(string: entry.url))
                .frame(width: 80, height: 80)
                .background(Color("AccentColor")
                    .ignoresSafeArea())
                .cornerRadius(8.0)
                .padding(.trailing, 8)
            
            Text(entry.name)
        }
    }
}

struct ProBierWidget: Widget {
    let kind: String = "ProBierWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            ProBierWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("ProBier")
        .description("This shows a random beer per day.")
    }
}

struct ProBierWidget_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProBierWidgetEntryView(entry: .init(
                date: .now,
                url: "https://images.punkapi.com/v2/227.png",
                name: "Pilsen")
            )
        }
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
