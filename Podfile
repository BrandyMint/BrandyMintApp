platform :ios, '6.0'

pod 'NUI', :head
pod 'NMCustomLabel', :git => 'git://github.com/BrandyMint/NMCustomLabel.git', :tag => '0.1.1'
pod 'AFNetworking' #, '>= 0.5.1'

# Отключил его в пользу ABMultiton
# pod 'CWLSynthesizeSingleton'

pod 'ABMultiton'

target :LogicTests do
  # OCMock, mock objects framework.
  # OCHamcrest, pattern matchers library.
  # OCMockito, another mock object framework.
  # Stubbilino, and library for method stubbing and swizzling.
  # Kiwi, a behavioural driven development library.
  pod 'OCMock'
end

#pod 'RestKit', '0.10.1'
#pod 'OHAttributedLabel'

post_install do |installer|
  installer.project.targets.each do |target|
    puts "#{target.name}"
  end
end
