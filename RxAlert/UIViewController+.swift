/*
 MIT License
 
 Copyright (c) RxSwiftCommunity
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

 */

import RxSwift
import RxCocoa
import UIKit
// MARK: - UIAlertController
extension UIAlertController {
    public func addAction(actions: [AlertAction]) -> Observable<Int> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            actions.map { action in
                UIAlertAction(title: action.title, style: action.style, handler: { _ in
                    observer.onNext(action.type)
                    observer.onCompleted()
                })
            }.forEach(self.addAction)
            return Disposables.create { self.dismiss(animated: true) }
        }
    }
}

// MARK: - UIViewController
extension UIViewController {
    public func alert(title: String?,
                      message: String? = nil,
                      actions: [AlertAction] = [AlertAction(title: "OK")],
                      preferredStyle: UIAlertController.Style = .alert,
                      vc: UIViewController? = nil) -> Observable<Int> {
        let parentVc = vc ?? self
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        return
            alertController
                .addAction(actions: actions)
                .do(onSubscribed: {
                    parentVc.present(alertController, animated: true)
                })
    }
}
