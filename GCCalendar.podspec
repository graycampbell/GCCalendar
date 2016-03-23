Pod::Spec.new do |s|
  s.name = 'GCCalendar'
  s.version = '1.0.6'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'A customizable calendar for iOS written in Swift.'
  s.description  = <<-DESC
                   A customizable calendar for iOS written in Swift.
                   DESC
  s.homepage = 'https://github.com/graycampbell/GCCalendar'
  s.authors = { 'Gray Campbell' => 'gray.campbell@icloud.com' }
  s.source = { :git => 'https://github.com/graycampbell/GCCalendar.git', :tag => s.version }

  s.ios.deployment_target = '9.0'

  s.source_files = 'GCCalendar/*.{h,m,swift}'

  s.requires_arc = true
  s.module_name = 'GCCalendar'
end
