import SwiftUI
import Combine

class SettingsStore: ObservableObject {
    @AppStorage("orderType") var orderType: Int = 0 // 0 = Ascending, 1 = Descending
    @AppStorage("showOnlyWithPhoto") var showOnlyWithPhoto: Bool = false
    @AppStorage("itemLimit") var itemLimit: Int = 10
}
