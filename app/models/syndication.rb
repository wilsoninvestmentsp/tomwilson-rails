class Syndication < ActiveRecord::Base
  mount_uploader :image, SyndicationUploader
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :annual_returns, dependent: :destroy
  accepts_nested_attributes_for :annual_returns, reject_if: :all_blank, allow_destroy: true

  before_save :unique_year

  scope :all_syndications, -> { all.order('created_at DESC') }
  scope :active_syndications, -> { all_syndications.where(active: true) }

  validates_presence_of :title, :purchase_price
  validates :purchase_price, :raise_amount, :preferred_return, :average_annual_return,
    :irr, :price_per_share, :loan_amount, :loan_rate, :building_size,
    :lot_size, :number_of_buildings, :number_of_tenants, numericality: { greater_than_or_equal_to: 0, allow_blank: true }, length: { maximum: 10,
    too_long: '%{count} digits is the maximum allowed' }

  def unique_year
    years = annual_returns.map(&:year)
    if years.count != years.uniq.count
      errors.add(:base, 'Annual Report Year Should Be Unique')
      false
    end
  end

  def self.by_user(user)
    user ? all_syndications : active_syndications
  end
end