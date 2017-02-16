class AnnualReturn < ActiveRecord::Base
  belongs_to :syndication
  scope :lastest_year, -> { pluck(:year).uniq.sort.last }
  scope :by_latest_year, -> { where(year: lastest_year) }
  scope :by_year, -> (year) { where(year: year) }
  validates_presence_of :year
  validate :unique_year

  def unique_year
    errors.add(:year, 'Annual Report Year Should Be Unique') if self.syndication.annual_returns.pluck(:year).include?(self.year)
  end

  validates :year, :projected_annual_return, :actual_annual_return, :quarter_1, :quarter_2, 
    :quarter_3, :quarter_4, numericality: { greater_than_or_equal_to: 0, allow_blank: true}, length: { maximum: 10,
    too_long: '%{count} digits is the maximum allowed' } 
end