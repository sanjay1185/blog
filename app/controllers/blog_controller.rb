require "net/http"
require "uri"
require 'hpricot'
require 'rubygems'

class BlogController < ApplicationController
  def index
  end

  def url_data
    uri = URI.parse(params[:url])

    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    doc=Hpricot(response.body)

    @images=[]
    doc.search("//img").each do |img|
      if img.attributes['height'].to_i >100
        p img.to_html
        if URI.parse(img.attributes['src']).host !=nil
          @images << img.attributes['src']
        else
          @images << "http://" + uri.host + "/"+ img.attributes['src']
        end
      end
    end
    @headline=doc.search("//title").inner_text
    @text=doc.search("//meta[@name='description']").first['content']
    render :update do |page|
      page.replace_html 'myDiv',:partial=>"comments"
      page.call 'StartSlideShow',@images
      page.replace_html 'url',params[:url].to_s
    end
  end

  def url_video
    video_url=params[:video_url]
    query_string = video_url.split( '?', 2)[1]
    @video_id=''
    if query_string
      params = CGI.parse(query_string)
      if params.has_key?("v")
        @video_id= params["v"][0]
      end
    end
    render :update do |page|
      page.show 'continue'
      page.replace_html 'video',:partial=>"video"
      page.hide 'video_data'
      page.hide 'comments'
      page.hide "step1"
      page.show "step2"
      page.remove 'checkbox_toggle'
      page.remove 'togglebutton'
    end
  end

  def generate_html
    comment=params[:comment]
    render :update do |page|
      if comment!=''
        page.replace_html 'comments',"Comment:<br/>#{comment}"
      else
        page.hide 'comments'
      end
      page.show 'continue'
      page.hide 'video_data'
      page.remove 'checkbox_toggle'
      page.remove 'togglebutton'
      page.hide "step1"
      page.show "step2"
    end
  end

  def form_html
    render :update do |page|
      page.hide 'video_data'
      page.hide "step1"
      page.hide 'continue'
      page.hide "step2"
      page.show "step3"
    end
  end

  

end
