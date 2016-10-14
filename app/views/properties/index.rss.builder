#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:media" => "http://search.yahoo.com/mrss/", :version => "2.0" do
  xml.channel do
    xml.title "Properties"
    xml.link properties_url
    xml.language "en"
    xml.itunes :title, 'Properties'
    xml.itunes :author, 'Tom Wilson Properties'
    for property in Property.all
      xml.item do
        xml.title property.raw_title
        xml.description property.city.capitalize, property.state.capitalize
        xml.itunes :title, property.raw_title
        xml.itunes :description, property.city.capitalize, property.state.capitalize
        xml.itunes :status, property.raw_status
        xml.itunes :offer_price, property.raw_offer_price
        xml.itunes :building_type, property.raw_building_type
      end
    end
  end
end