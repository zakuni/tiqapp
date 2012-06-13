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
    attr_accessor :urlField
    
    def applicationDidFinishLaunching(a_notification)
        @noimage = [
        {"id" => "2aT", "ext" => "jpg"},
        {"id" => "lK", "ext" => "jpg"},
        {"id" => "19A", "ext" => "jpg"}
        ]
    end

    def searchImage(sender)
        Net::HTTP.start('api.tiqav.com') do |http|
            response = http.get('/search.json?q=' + searchField.stringValue)
            result = nil
            begin
                result = JSON.parse(response.body)
            rescue JSON::ParserError
                result = @noimage
            end
            @one = result[rand(result.length)]
        end
        
        imageView.setHidden(false)
        tiqavURL = 'http://tiqav.com/' + @one['id']
        imgURL = 'http://img.tiqav.com/' + @one['id'] + '.' + @one['ext']
        img = NSImage.new
        img.initByReferencingURL(NSURL.URLWithString(imgURL))
        imageView.setImage(img)
        #imageView.setFrameSize(img.size)
        urlField.setStringValue(tiqavURL)
    end
end

