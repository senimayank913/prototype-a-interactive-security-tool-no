import UIKit

// Model for security notifications
struct SecurityNotification {
    let title: String
    let message: String
    let severity: Severity
    let timestamp: Date
}

enum Severity: String, CaseIterable {
    case low, medium, high
}

class JaguarInteractiveSecurityNotifier {
    private var securityNotifications = [SecurityNotification]()
    private let notificationTableView = UITableView()
    
    init(view: UIView) {
        setupTableView(on: view)
    }
    
    func addNotification(_ notification: SecurityNotification) {
        securityNotifications.append(notification)
        notificationTableView.reloadData()
    }
    
    private func setupTableView(on view: UIView) {
        notificationTableView.dataSource = self
        notificationTableView.delegate = self
        view.addSubview(notificationTableView)
        notificationTableView.translatesAutoresizingMaskIntoConstraints = false
        notificationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notificationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        notificationTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        notificationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension JaguarInteractiveSecurityNotifier: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return securityNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)
        let notification = securityNotifications[indexPath.row]
        cell.textLabel?.text = notification.title
        cell.detailTextLabel?.text = notification.message
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = securityNotifications[indexPath.row]
        print("Selected notification: \(notification.title) - \(notification.message) - \(notification.severity.rawValue) - \(notification.timestamp)")
    }
}

// Example usage
let notifier = JaguarInteractiveSecurityNotifier(view: UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 600)))
notifier.addNotification(SecurityNotification(title: "Suspicious login attempt", message: "Someone tried to login from an unknown location", severity: .high, timestamp: Date()))
notifier.addNotification(SecurityNotification(title: "System update available", message: "A new update is available for your operating system", severity: .low, timestamp: Date()))