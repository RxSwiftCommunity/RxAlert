import RxSwift
import RxCocoa
import UIKit
// MARK: - UIAlertController
extension UIAlertController {
    
    public func addAction(actions: [AlertAction]) -> Observable<Int> {
        return Observable.create { [weak self] observer in
            actions.map { action in
                return UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(action.type)
                    observer.onCompleted()
                }
                }.forEach { action in
                    self?.addAction(action)
            }
            
            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension UIViewController {
    public func alert(title: String?,
               message: String? = nil,
               actions: [AlertAction],
               preferredStyle:UIAlertController.Style = .alert,
               vc:UIViewController) -> Observable<Int> {
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        return actionSheet.addAction(actions: actions)
            .do(onSubscribed: {
                vc.present(actionSheet, animated: true, completion: nil)
            })
    }
}
