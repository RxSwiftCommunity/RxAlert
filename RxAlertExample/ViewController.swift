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

import UIKit
import RxAlert
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let items: BehaviorRelay<[String]> = BehaviorRelay(value: ["Alert single", "Alert double", "Action sheet single", "Action sheet triple"])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { [unowned self] index in
                self.tableView.deselectRow(at: index, animated: true)
                switch index.row {
                case 0:
                    self.alert(title: "RxAlert",
                               message: "RxAlert Message")
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { index in
                            print("index: \(index)")
                        })
                        .disposed(by: self.disposeBag)
                    break
                case 1:
                    self.alert(title: "RxAlert",
                               message: "RxAlert Message",
                               actions: [AlertAction(title: "OK", type: 0, style: .default),
                                         AlertAction(title: "Cancel", type: 1, style: .destructive)])
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { index in
                            print("index: \(index)")
                        })
                        .disposed(by: self.disposeBag)
                    break
                case 2:
                    self.alert(title: "RxAlert",
                               message: "RxAlert Message",
                               actions: [AlertAction(title: "OK")],
                               preferredStyle: .actionSheet)
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { index in
                            print("index: \(index)")
                        })
                        .disposed(by: self.disposeBag)
                    break
                case 3:
                    self.alert(title: "RxAlert",
                               message: "RxAlert Message",
                               actions: [AlertAction(title: "OK", type: 0, style: .default),
                                         AlertAction(title: "First", type: 1, style: .default),
                                         AlertAction(title: "Second", type: 1, style: .destructive),
                                         AlertAction(title: "Cancel", type: 2, style: .cancel)],
                               preferredStyle: .actionSheet)
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { index in
                            print("index: \(index)")
                        })
                        .disposed(by: self.disposeBag)
                    break
                default: break
                }
            })
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


        /***************************************
        Create an instance of password input item.
        You can make various changes to UITextField of UIAlertViewController.
         *****************************************/
        let textField2 = UITextField()
        textField2.textColor = .purple
        textField2.clearButtonMode = .always
        textField2.keyboardType = .emailAddress
        textField2.returnKeyType = .google
        textField2.spellCheckingType = .yes
        textField2.autocapitalizationType = .none
        textField2.keyboardAppearance = .dark
        textField2.clearsOnBeginEditing = true
        textField2.adjustsFontSizeToFitWidth = true
        textField2.minimumFontSize = 10
        /***************************************
         UITextFieldDelegate is enabled only for
         the password input field of UITextField.
         *****************************************/
        textField2.delegate = self

        alert(title: "RxAlert",
              message: "We have made it easy to implement UIAlertController using RxSwift.",
              actions: [AlertAction(title: "OK", type: 0, style: .default),
                        AlertAction(textField: UITextField(), placeholder: "user name"),
                        AlertAction(textField: textField2, placeholder: "password")])
            .subscribe(onNext: { (output) in
                print("🤩The alert button has been tap.🤩")
                output.textFields?.forEach {
                    if let text = $0.text {
                        print(text)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell"), curriedArgument: { i, item ,cell in
                cell.textLabel?.text = item
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        print(string)
        return true
    }
}
