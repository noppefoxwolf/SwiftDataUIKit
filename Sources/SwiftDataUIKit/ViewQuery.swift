import SwiftData
import SwiftUI
import Combine

public typealias ViewQuery = SwiftDataUIKit.Query

@propertyWrapper
public struct Query<T: PersistentModel> {
    public typealias Value = [T]
    public typealias FetchDescriptorType = FetchDescriptor<T>
    
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
    public var projectedValue: AnyPublisher<[T], Never> {
        publisher.eraseToAnyPublisher()
    }
    private let fetchDescriptor: FetchDescriptorType
    public init(_ fetchDescriptor: FetchDescriptorType) {
        self.fetchDescriptor = fetchDescriptor
    }
    
    let publisher = CurrentValueSubject<[T], Never>([])
    
    @MainActor
    public func load(_ view: UIView, modelContainer: ModelContainer) {
        let rootView = QueryView(
            query: SwiftData.Query(fetchDescriptor),
            onChanged: { [weak publisher] in
                publisher?.send($0)
            }
        )
        let hostingConfiguration = UIHostingConfiguration(
            content: { rootView.modelContainer(modelContainer) }
        )
        let contentView = hostingConfiguration.makeContentView()
        view.addSubview(contentView)
        contentView.isHidden = true
    }
}
