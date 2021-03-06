Pod::Spec.new do |spec|

  spec.name         = 'CitySearchUserStory'
  spec.source_files           = 'Sources/**/*.swift'

  spec.ios.deployment_target = '12.0'

  spec.version = '1.0.0'
  spec.authors = 'Alexandr Shipin'
  spec.license = 'Empty License'
  spec.homepage = 'https://github.com/shsanek/Weather'
  spec.source = { :git => 'https://github.com/shsanek/Weather' }
  spec.summary = 'CitySearchUserStory'

  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.swift'
  end

  spec.dependency 'Core'
  spec.dependency 'Utils'
  spec.dependency 'DIGreatness'
  spec.dependency 'Design'

end
