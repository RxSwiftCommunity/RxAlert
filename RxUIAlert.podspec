#
#  Be sure to run `pod spec lint Direction.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "RxUIAlert"
  s.version      = "1.3.1"
  s.summary      = "RxUIAlert"
  s.description  = <<-DESC
                      Extension UIAlertController with Rx.
                      Use UIAlertController with Rx.
                   DESC

  s.homepage     = "https://github.com/RxSwiftCommunity/RxAlert"
  s.license      = "MIT"
  s.author             = { ' RxSwift Community ' => ' community@rxswift.org ' }
  s.source       = { :git => "https://github.com/RxSwiftCommunity/RxAlert.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.source_files  = "RxAlert/*.swift"
  s.frameworks = 'Foundation'
  s.frameworks = 'UIKit'

  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
end
