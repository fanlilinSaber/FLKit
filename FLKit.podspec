Pod::Spec.new do |s|
  s.name = "FLKit"
  s.version = "1.0.0"
  s.summary = "Simplify FLKit."
  s.homepage = "https://github.com/fanlilinSaber/FLKit"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "fanlilin" => 'fanlilin@ifocusing.com' }
  s.platform = :ios,"8.4"
  s.source = { :git => "https://github.com/fanlilinSaber/FLKit.git", :tag => "v#{s.version}", :submodules => "true" }
  s.public_header_files = "Sources/FLKit.h"
  s.source_files = "Sources/FLKit.h"
  
  s.subspec "Category" do |ss|
    ss.source_files = "Sources/Category/**/*"
  end
  
  s.subspec "Text" do |ss|
    ss.source_files = "Sources/Text/**/*"
    ss.dependency "FLKit/Category"
  end
  
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
