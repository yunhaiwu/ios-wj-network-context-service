Pod::Spec.new do |s|

s.name         = "WJNetworkContextService"
s.version      = "1.0.1"
s.summary      = "network context service."

s.description  = <<-DESC
    网络环境服务，网络连接状态、通知等
DESC

s.homepage     = "https://github.com/yunhaiwu"


s.license      = { :type => "MIT", :file => "LICENSE" }

s.author       = { "吴云海" => "halayun@qq.com" }


s.platform     = :ios, "6.0"

s.source       = { :git => "https://github.com/yunhaiwu/ios-wj-network-context-service.git", :tag => "#{s.version}" }

s.source_files  = "Classes/*.{h,m}"
s.exclude_files = "Example"

s.public_header_files = "Classes/*.h"

s.frameworks = "Foundation", "UIKit"

s.requires_arc = true

s.dependency "WJLoggingAPI"
s.dependency "WJAppContext", '>=2.0'
s.dependency "AFNetworking/Reachability", '~> 3.1'

end
