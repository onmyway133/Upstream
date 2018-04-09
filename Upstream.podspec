Pod::Spec.new do |s|
  s.name             = "Upstream"
  s.summary          = "Adapted Data Source"
  s.version          = "0.2.0"
  s.homepage         = "https://github.com/hyperoslo/Upstream"
  s.license          = 'MIT'
  s.author           = { "hyperoslo" => "ios@hyper.no" }
  s.source           = {
    :git => "https://github.com/hyperoslo/Upstream.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.2'

  s.requires_arc = true
  s.source_files = 'Sources/**/*'

  s.ios.frameworks = 'UIKit', 'Foundation'
  s.osx.frameworks = 'Cocoa', 'Foundation'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
end
