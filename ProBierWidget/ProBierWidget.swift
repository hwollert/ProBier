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
            name: "Pilsen",
            id: "4"
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            url: "https://images.punkapi.com/v2/227.png",
            name: "Pilsen",
            id: "4"
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries: [SimpleEntry] = []
            let currentDate = Date()
            
            do {
                let beer = try await BeerManager.shared.getRandomBeer()
                let entry = SimpleEntry(
                    date: Date(),
                    url: beer.image_url ?? "",
                    name: beer.name,
                    id: "\(beer.id)"
                )
                entries.append(entry)
            } catch ErrorType.tooManyRequests {
                print("too many requests")
            } catch ErrorType.notAvailable {
                print("not available")
            } catch let error {
                print("Error: \(error)")
            }
            
            let loadAfterDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            let timeline = Timeline(entries: entries, policy: .after(loadAfterDate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let url: String
    let name: String
    let id: String
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
                .cornerRadius(8.0)
                .padding(.trailing, 8)
            
            Text(entry.name)
        }
        .widgetURL(URL(string: "beer-widget://\(entry.id)"))
        .padding()
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("WidgetBackground"))
        }
        .configurationDisplayName("ProBier")
        .description("This shows a random beer per day.")
        .supportedFamilies([.systemSmall])
    }
}

struct ProBierWidget_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProBierWidgetEntryView(entry: .init(
                date: .now,
                url: "https://images.punkapi.com/v2/227.png",
                name: "Pilsen",
                id: "4")
            )
        }
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
