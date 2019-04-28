import UIKit

// MARK: - Action
public struct AlertAction {
    
    public let title: String
    public let type: Int
    public let style: UIAlertAction.Style
    
    public init(title: String,
         type: Int,
         style: UIAlertAction.Style) {
        self.title = title
        self.type = type
        self.style = style
    }
}
