class Testimony < ActiveRecord::Base

	before_create :set_order

	validates_presence_of :quote

	protected

	# Begin set_order :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
	def set_order
	
		self.sort = Testimony.all.count
	
	end
	# End set_order :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

end