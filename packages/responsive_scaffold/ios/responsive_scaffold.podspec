#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'responsive_scaffold'
  s.version          = '0.0.1'
  s.summary          = 'On mobile it shows a list and pushes to details and on tablet it shows the List and the selected item.'
  s.description      = <<-DESC
On mobile it shows a list and pushes to details and on tablet it shows the List and the selected item.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

