import SwiftUI
import SwiftData

struct QueryView<Item: PersistentModel>: View {
    let items: SwiftData.Query<[Item].Element, [Item]>
    let onChanged: ([Item]) -> Void
    
    init(query: SwiftData.Query<[Item].Element, [Item]>, onChanged: @escaping ([Item]) -> Void) {
        self.items = query
        self.onChanged = onChanged
    }
    
    var body: some View {
        EmptyView()
            .onChange(of: items.wrappedValue) {
                onChanged(items.wrappedValue)
            }
    }
}
