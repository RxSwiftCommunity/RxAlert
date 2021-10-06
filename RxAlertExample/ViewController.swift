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

import RxAlert
import RxCocoa
import RxSwift
import UIKit

final class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    let items = ["Alert single",
                 "Alert double",
                 "Action sheet single",
                 "Action sheet triple",
                 "Alert UITextField"]

    let disposeBag = DisposeBag()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        /***************************************
         Create an instance of password input item.
         You can make various changes to UITextField of UIAlertViewController.
          *****************************************/
        let textField2 = UITextField()
        textField2.textColor = .black
        textField2.clearButtonMode = .always
        textField2.keyboardType = .twitter
        textField2.isSecureTextEntry = true
        textField2.returnKeyType = .google
        textField2.keyboardAppearance = .dark
        textField2.clearsOnBeginEditing = true
        /***************************************
         UITextFieldDelegate is enabled only for
         the password input field of UITextField.
         *****************************************/
        textField2.delegate = self

        rx.alert(title: "RxAlert",
                 message: "We have made it easy to implement UIAlertController using RxSwift.",
                 actions: [AlertAction(title: "OK", type: 0, style: .default),
                           AlertAction(textField: UITextField(), placeholder: "user name"),
                           AlertAction(textField: textField2, placeholder: "password")])
            .subscribe(onNext: { output in
                print("🤩The alert button has been tap.🤩")
                output.textFields?.forEach {
                    if let text = $0.text {
                        print(text)
                    }
                }
                print("Action: \(output.alertAction)")
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_: UITextField,
                   shouldChangeCharactersIn _: NSRange,
                   replacementString string: String) -> Bool
    {
        print(string)
        return true
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            rx.alert(title: "RxAlert",
                     message: "RxAlert Message")
                .subscribe(onNext: { index in
                    print("index: \(index)")
                })
                .disposed(by: disposeBag)
        case 1:
            rx.alert(title: "RxAlert",
                     message: "RxAlert Message",
                     actions: [AlertAction(title: "OK", type: 0, style: .default),
                               AlertAction(title: "Cancel", type: 1, style: .destructive)],
                     tintColor: nil)
                .subscribe(onNext: { index in
                    print("index: \(index)")
                })
                .disposed(by: disposeBag)
        case 2:
            rx.alert(title: "RxAlert",
                     message: "RxAlert Message",
                     actions: [AlertAction(title: "OK")],
                     preferredStyle: .actionSheet)
                .subscribe(onNext: { index in
                    print("index: \(index)")
                })
                .disposed(by: disposeBag)
        case 3:
            rx.alert(title: "RxAlert",
                     message: "RxAlert Message",
                     actions: [AlertAction(title: "OK", type: 0, style: .default),
                               AlertAction(title: "First", type: 1, style: .default),
                               AlertAction(title: "Second", type: 1, style: .destructive),
                               AlertAction(title: "Cancel", type: 2, style: .cancel)],
                     preferredStyle: .actionSheet)
                .subscribe(onNext: { index in
                    print("index: \(index)")
                })
                .disposed(by: disposeBag)
        case 4:
            let textField2 = UITextField()
            textField2.textColor = .black
            textField2.clearButtonMode = .always
            textField2.keyboardType = .twitter
            textField2.isSecureTextEntry = true
            rx.alert(title: "RxAlert UITextField",
                     message: "RxAlert UItextField MEssage",
                     actions: [AlertAction(title: "OK", type: 0, style: .default),
                               AlertAction(textField: UITextField(), placeholder: "user name"),
                               AlertAction(textField: textField2, placeholder: "password")])
                .subscribe(onNext: { output in
                    output.textFields?.forEach {
                        if let text = $0.text {
                            print(text)
                        }
                    }
                }).disposed(by: disposeBag)
        default: break
        }
    }
}
