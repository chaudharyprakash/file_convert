class AddPdfColumnToUsers < ActiveRecord::Migration
	def change
		add_attachment :users, :pdf
		
	end
end
