Pod::Spec.new do |s|
s.name             = 'MahsaHLSParser'
s.version          = '1.0'
s.summary          = 'MahsaHLSParser creation for iOS'
s.description      = <<-DESC
                    This highletbale framework to parse .m8u3 files. enjoy it
                    DESC

s.homepage         = 'https://github.com/engmahsa/HLSParser.git'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'username' => 'mailbox.mahsa@gmail.com' }
s.source           = { :git => 'https://github.com/engmahsa/HLSParser.git', :tag => s.version.to_s }
s.ios.deployment_target = '10.0'
s.source_files = '*'
end
