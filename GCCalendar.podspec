Pod::Spec.new do |s|
  s.name = 'GCCalendar'
  s.version = '1.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'A customizable calendar for iOS written in Swift.'
  s.description  = <<-DESC
                   A customizable calendar for iOS written in Swift.
                   DESC
  s.homepage = 'https://github.com/graycampbell/GCCalendar'
  s.authors = { 'Gray Campbell' => 'gray.campbell@outlook.com' }
  s.source = { :git => 'https://github.com/graycampbell/GCCalendar.git', :branch => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'GCCalendar/GCCalendar/Calendar/*.{h,m,swift}'

  s.requires_arc = true
  s.module_name = 'GCCalendar'
end
