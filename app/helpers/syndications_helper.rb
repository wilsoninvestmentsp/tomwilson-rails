module SyndicationsHelper
  def quarterly_price(quarter)
    quarter.present? ? raw_price(quarter) : '-' 
  end
end