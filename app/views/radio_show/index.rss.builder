#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:media" => "http://search.yahoo.com/mrss/", :version => "2.0" do
  xml.channel do
    xml.title "Radio Show"
    xml.link radio_show_url
    xml.language "en"
    xml.itunes :title, 'Radio Show'
    xml.itunes :author, 'Tom Wilson Properties'
    for video in @videos
      xml.item do
        xml.title video['snippet']['title']
        xml.description video['snippet']['description']
        xml.itunes :title, video['snippet']['title']
        xml.itunes :description, video['snippet']['description']
        xml.itunes :guid, video['id']['videoId']
        link = 'https://www.youtube.com/watch?v=' + video['id']['videoId']
        xml.itunes :link, link
      end
    end
  end
end