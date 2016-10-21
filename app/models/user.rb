class User < ActiveRecord::Base
	has_attached_file :pdf
	# validates_attachment_content_type :pdf, :content_type => ['image/jpg', 
 #                                                            'image/jpeg', 
 #                                                            'image/png', 
 #                                                            'application/pdf', 
 #                                                            'application/msword', 
 #                                                            'application/vnd.ms-office',
 #                                                            'application/vnd.ms-excel',
 #                                                            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
 #                                                            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
 #                                                            'application/vnd.openxmlformats-officedocument.presentationml.presentation',
 #                                                            'application/vnd.ms-powerpoint',
 #                                                              /\Aimage\/.*\Z/]

  do_not_validate_attachment_file_type :pdf

end
