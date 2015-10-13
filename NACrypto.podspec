Pod::Spec.new do |s|

  s.name         = "NACrypto"
  s.version      = "1.0.3"
  s.summary      = "Objective-C library for libsodium (NaCl)"
  s.homepage     = "https://github.com/gabriel/NACrypto"
  s.license      = { :type => "MIT" }
  s.author       = { "Gabriel Handford" => "gabrielh@gmail.com" }
  s.source       = { :git => "https://github.com/gabriel/NACrypto.git", :tag => s.version.to_s }
  s.requires_arc = true

  s.ios.platform = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.ios.source_files = 'NACrypto/**/*.{c,h,m}'

  s.osx.platform = :osx, "10.8"
  s.osx.deployment_target = "10.8"
  s.osx.source_files = 'NACrypto/**/*.{c,h,m}'

end
