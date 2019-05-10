#
# Be sure to run `pod lib lint ios-axe-crypto.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ios-axe-crypto'
  s.version          = '0.1.0'
  s.summary          = 'iOS library with AXE cryptographic primitives'

  s.description      = <<-DESC
Contains BigInt, X11 implementation, secp256k1 and BLS signatures dependencies, DSKey implementation and blockchain-related categories on Foundation objects
                       DESC

  s.homepage         = 'https://github.com/axerunners/ios-axe-crypto'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AXErunners' => 'info@axerunners.com' }
  s.source           = { :git => 'https://github.com/axerunners/ios-axe-crypto.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/axerunners'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ios-axe-crypto/**/*.{h,m,mm}'
  s.public_header_files = 'ios-axe-crypto/**/*.h'
  s.private_header_files = 'ios-axe-crypto/crypto/x11/*.h'

  s.framework = 'Foundation'
  s.compiler_flags = '-Wno-comma'
  s.dependency 'secp256k1_axe', '0.1.2'
  s.dependency 'bls-signatures-pod', '0.2.9'

end
