#
#  AppDelegate.rb
#  tiqapp
#
#  Created by zakuni on 12/06/12.
#  Copyright 2012年 __MyCompanyName__. All rights reserved.
#
require 'net/http'
require 'json'
require 'open-uri'

class AppDelegate
    attr_accessor :window
    attr_accessor :imageView
    attr_accessor :searchField
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    def searchImage(sender)
        Net::HTTP.start('api.tiqav.com') do |http|
            response = http.get('/search.json?q=' + searchField.stringValue)
            # puts response
            result = JSON.parse(response.body)
            @one = result[rand(result.length)]
        end
        
        img = NSImage.new
        img.initByReferencingURL(NSURL.URLWithString('http://img.tiqav.com/' + @one['id'] + '.' + @one['ext']))
        imageView.setImage(img)
    end
end

