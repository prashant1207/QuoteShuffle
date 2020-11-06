//
//  QuoteShuffleWidget.swift
//  QuoteShuffleWidget
//
//  Created by Prashant Tiwari on 12/10/20.
//

import WidgetKit
import SwiftUI
import Intents
import QuoteShuffleService


struct Provider: IntentTimelineProvider {
    let service = QuoteService()
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: service.getRandomQuote(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), quote: service.getRandomQuote(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 24 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let quote =  service.getRandomQuote()
            var entry = SimpleEntry(date: entryDate, quote: quote, configuration: configuration)
            entry.colors = service.getColors(quote)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: Quote
    var colors: [Color] = [Color.black, Color.black]
    let configuration: ConfigurationIntent
}



struct QuoteMediumView: View {
    var quote: Quote
    var body: some View {
        VStack {
            Image(systemName: Constants.icons.randomElement() ?? "quote.bubble")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            Text(quote.quote)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            Text(quote.author == "" ? "Unknown" : quote.author)
                .font(.system(size: 12))
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .widgetURL(getQuoteUrl(quote))
        .padding()
        .foregroundColor(Color.white)
    }

    func getQuoteUrl(_ quote: Quote) -> URL? {
        let prefix = "quoteshuffle://"
        guard let encodedQuote = quote.getEncodedString() else {
            return URL(string: prefix)
        }

        return URL(string: encodedQuote)
    }
}

struct QuoteShuffleWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        QuoteMediumView(quote: entry.quote)
    }
}

@main
struct QuoteShuffleWidget: Widget {
    let kind: String = "QuoteShuffleWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            QuoteShuffleWidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    ZStack {
                        Image(Constants.background.randomElement() ?? "background1")
                            .resizable()
                            .scaledToFill()
                        LinearGradient(gradient: Gradient(colors: entry.colors),
                                       startPoint: UnitPoint(x: 0, y: 0),
                                       endPoint: UnitPoint(x: 0, y: 1))
                            .opacity(0.64)
                    }
                )

        }
        .supportedFamilies([.systemMedium, .systemLarge])
        .configurationDisplayName("Shuflerr")
        .description("Shows wonderful and fresh quotes")
    }
}

struct QuoteShuffleWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuoteShuffleWidgetEntryView(entry: SimpleEntry(date: Date(), quote: QuoteService().getRandomQuote(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
