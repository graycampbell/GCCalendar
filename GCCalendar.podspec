Pod::Spec.new do |s|
  s.name = 'GCCalendar'
  s.version = '1.1.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'A customizable calendar for iOS 9+ written in Swift.'
  s.description  = <<-DESC
                   A Swift framework that provides a customizable calendar UI component for iOS.
                   DESC
  s.homepage = 'https://github.com/graycampbell/GCCalendar'
  s.authors = { 'Gray Campbell' => 'gray.campbell@icloud.com' }
  s.source = { :git => 'https://github.com/graycampbell/GCCalendar.git', :tag => s.version }

  s.ios.deployment_target = '9.0'

  s.source_files = 'GCCalendar/*.{h,m,swift}'

  s.requires_arc = true
  s.module_name = 'GCCalendar'
end
