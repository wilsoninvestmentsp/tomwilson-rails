class Chart < ActiveRecord::Base
  belongs_to :property
  validates_presence_of :title,:value,:property_id

  def raw_value
    helper.number_with_precision(self.value,precision: 2,delimiter: ',')
  end

  private
  def helper
    @helper ||= Class.new do
     include ActionView::Helpers::NumberHelper
   end.new
 end
end