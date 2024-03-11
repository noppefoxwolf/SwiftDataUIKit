import UIKit
import SwiftData
import SwiftDataUIKit

class ViewController: UIViewController {
    @ViewQuery(FetchDescriptor<User>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)]))
    var users: [User]
    
    let label: UILabel = UILabel()
    
    let button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = "Add user"
        return button
    }()
    
    let modelContainer = try! ModelContainer(
        for: User.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let stackView = UIStackView(
            arrangedSubviews: [
                label,
                button
            ]
        )
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            view.trailingAnchor.constraint(
                equalTo: stackView.safeAreaLayoutGuide.trailingAnchor,
                constant: 20
            ),
        ])
        
        button.addAction(UIAction { [unowned self] _ in
            try! modelContainer.mainContext.transaction {
                modelContainer.mainContext.insert(User())
            }
        }, for: .primaryActionTriggered)

        _users.load(view, modelContainer: modelContainer)
        
        Task {
            for await users in $users.values {
                label.text = "user count: \(users.count.formatted())"
            }
        }
    }
}
