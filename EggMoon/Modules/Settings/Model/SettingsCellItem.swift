enum SettingsCellItem: Identifiable, CaseIterable {
    var id: Self { self }
    
    case notifications
    case about
    case privacy
    
    var title: String {
        switch self {
            case .notifications:
                "Notifications"
            case .about:
                "About the developer"
            case .privacy:
                "Privacy Policy"
        }
    }
    
    var path: String {
        switch self {
            case .notifications:
                ""
            case .about:
                "https://sites.google.com/view/eggmoon/home"
            case .privacy:
                "https://sites.google.com/view/eggmoon/privacy-policy"
        }
    }
}
