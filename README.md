# HLSParser
This is a Swift framework to parse HTTP Live Streaming (HLS) data.


Adding alternate media to a master playlist allows a provider to specify one of a set of variant playlists as an override of the main presentation. The client plays only the override media (audio or video). This allows a presentation to offer multiple versions of the media without requiring the provider to store duplicate media, or requiring the client to download all variants when it only needs one. It also allows additional media to be offered subsequently without remastering the original content.( The player is a client here, it’s responsible for playing the HLS content in the user’s device. The player begins by fetching the content of the .m3u8 file, using the media playlist URL’s it will download the media chunks in sequence and reassembles them to present the continuous streaming to the user.)

# Example
This code is an example of adding an alternate media playlist:

```json
{
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=335769,RESOLUTION=480x204
rendition/rendition.m3u8?assetId=4034861117001&videoId=4034552795001

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=53960
rendition/rendition.m3u8?assetId=4034855729001&videoId=4034552795001

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=586889,RESOLUTION=640x272
rendition/rendition.m3u8?assetId=4034861740001&videoId=4034552795001

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=836039,RESOLUTION=854x362
rendition/rendition.m3u8?assetId=4034861116001&videoId=4034552795001
}
```

These are the tags used in an alternate media playlist example:
**EXT-X-STREAM-INF:** Indicates that the next URL in the playlist file identifies another playlist file.
This framework includes two methods. One for parsing these streaming tags from main link(which given to player as an adaptive link) and another method to find baseURL and concatenate with link attribute exist in tags.

# Installation
To use [CocoaPods](https://cocoapods.org) just add this to your Podfile:

```swift
pod ‘MahsaHLSParser’
```

# Usage
To use the parser just do the following:


```swift
import HLSParser

let parser = HLSParser()
if let url = URL(string: "https://d2zihajmogu5jn.cloudfront.net/sintel/master.m3u8") {
     parser.hLSParserDelegate = self
      parser.parseStreamTags(link: url)
}
```
HLSParser, parse the main link which given to player, and it returns an array of metadata via delegation which parsed from stream tags. The array includes different resolutions that streaming supports for a specific link, And some sublinks. Player will automatically switch between the resolutions according users’ internet speed. But for manually change the links, you can use this metadata.  


