# class User < ActiveRecord::Base
# 	has_attached_file :pdf, :default_url => "/images/missing.png"
# 	validates_attachment_content_type :pdf, :content_type => [ 'image/jpeg' 'image/jpg', 'image/png', 'application/pdf', 'application/msword', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.ms-powerpoint' ]
# end
