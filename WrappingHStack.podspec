Pod::Spec.new do |s|
  s.name             = 'WrappingHStack'
  s.version          = '2.2.11'
  s.summary          = 'Like HStack, but automatically positions overflowing elements on next lines.'
  s.description      = <<-DESC
  WrappingHStack is a UI Element that works in a very similar way to HStack, but automatically positions overflowing elements on next lines.
                       DESC

  s.homepage         = 'https://github.com/dkk/WrappingHStack'
  s.screenshots     = 'https://github.com/dkk/WrappingHStack/raw/main/example.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Klöck' => 'kloeck@pappuga.com' }
  s.source           = { :git => 'https://github.com/dkk/WrappingHStack.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target  = '10.15'
  s.swift_version = '5.0'
  s.source_files = 'Sources/WrappingHStack/**/*'
end
