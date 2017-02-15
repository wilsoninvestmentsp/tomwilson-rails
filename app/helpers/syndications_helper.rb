module SyndicationsHelper
  def Quarterly_Price(quarter)
    quarter.present? ? raw_price(quarter) : '-' 
  end
end