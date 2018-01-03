Pod::Spec.new do |s|
  s.name = 'GCCalendar'
  s.version = '2.3.1'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'A customizable calendar for iOS 9+ written in Swift.'
  s.description  = <<-DESC
                   A customizable calendar UI component for iOS 9+ written in Swift.
                   DESC
  s.homepage = 'https://github.com/graycampbell/GCCalendar'
  s.author = 'Gray Campbell'
  s.source = { :git => 'https://github.com/graycampbell/GCCalendar.git', :tag => s.version }

  s.ios.deployment_target = '9.0'

  s.source_files = 'GCCalendar/*.{h,m,swift}'

  s.requires_arc = true
  s.module_name = 'GCCalendar'
end
