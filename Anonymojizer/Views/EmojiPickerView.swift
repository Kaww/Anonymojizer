import SwiftUI

struct Emoji: Identifiable {
    let value: Character

    init(_ value: Character) {
        self.value = value
    }

    var id: Character { value }
}

struct EmojiSection: Identifiable {
    let title: String
    let emojis: [Emoji]

    init(title: String, range: ClosedRange<Int>) {
        self.title = title
        self.emojis = range
            .compactMap { UnicodeScalar($0) }
            .map { Emoji(Character($0)) }
    }

    var id: String { title }
}

enum Emojis {

    enum Section: Int, CaseIterable, Identifiable {
        case smileysAndPeople
        case animalsAndNature
        case foodAndDrinks
        case activity
        case travelAndPlaces
        case objects
        case symbols
        case flags

        var section: EmojiSection {
            switch self {
            case .smileysAndPeople:
                return EmojiSection(
                    title: "Smileys & People",
                    range: 0x1F600...0x1F64F
                )

            case .animalsAndNature:
                return EmojiSection(
                    title: "Animals & Nature",
                    range: 0x2600...0x26FF
                )

            case .foodAndDrinks:
                return EmojiSection(
                    title: "Food & Drinks",
                    range: 0xFE00...0xFE0F
                )

            case .activity:
                return EmojiSection(
                    title: "Activity",
                    range: 0x1F900...0x1F9FF
                )

            case .travelAndPlaces:
                return EmojiSection(
                    title: "Travel & Places",
                    range: 0x1F680...0x1F6FF
                )

            case .objects:
                return EmojiSection(
                    title: "Objects",
                    range: 9100...9300
                )

            case .symbols:
                return EmojiSection(
                    title: "Symbols",
                    range: 0x1F300...0x1F5FF
                )

            case .flags:
                return EmojiSection(
                    title: "Flags",
                    range: 0x1F1E6...0x1F1FF
                )
            }
        }

        var id: Int { rawValue }
    }
}

struct EmojiPickerView: View {
    let emojisRange = 0x1F600...0x1F64F

    private let columns = [
        GridItem(.adaptive(minimum: 40))
    ]

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20, pinnedViews: .sectionHeaders) {
                ForEach(Emojis.Section.allCases) { section in
                    Section {
                        ForEach(section.section.emojis) { emoji in
                            Text(String(emoji.value))
                                .font(.system(size: 40))
                        }
                    } header: {
                        Text(section.section.title)
                    }
                }

//                ForEach
//                    ForEach(emojisRange, id: \.self) { emoji in
//                        Text(String(UnicodeScalar(emoji) ?? "-"))
//                            .font(.system(size: 40))
//                    }
            }
            .padding(.horizontal)
        }
    }
}

struct EmojiPickerView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPickerView()
    }
}
