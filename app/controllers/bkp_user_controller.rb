class UserController < ApplicationController

	def pdf_to_jpg
		@user = User.first
	end

	def do_pdf_to_jpg
		@user=User.create(pdf: params[:pdf])

		@path_in = @user.pdf.path

		temp1 = @user.pdf.path

		@path_out = temp1.slice(0..temp1.rindex(/\//)) + 'output/'

		Docsplit.extract_images(@path_in, {output: @path_out})

		temp2 = @user.pdf.url

		@relative_path = temp2.slice(0..temp2.rindex(/\//)) + 'output/'

		@images = Dir.entries(Rails.root.to_s + '/public'+@relative_path).reject {|f| File.directory?(f) || f[0].include?('.')}
		
	end

	def word_to_pdf
		@user = User.first
	end

	def do_word_to_pdf
		@user=User.create(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
		query = "cd "+@path_out+" && unoconv -f pdf "+@user.pdf.original_filename
		system(query)
		file = @path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"
		send_file file, :type=>"application/pdf", :x_sendfile=>true
	end

	def pdf_to_word
		@user = User.first
	end

	def do_pdf_to_word
		@user=User.create(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
		query = "cd "+@path_out+" && abiword --to=doc "+@user.pdf.original_filename
		system(query)
		file = @path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".doc"
		send_file file, :type=>"application/pdf", :x_sendfile=>true
	end

	def excel_to_pdf
		@user = User.first
	end

	def do_excel_to_pdf
		@user=User.create(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
		query = "cd "+@path_out+" && unoconv -d document --format=pdf "+@user.pdf.original_filename
		system(query)
		file = @path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"
		send_file file, :type=>"application/pdf", :x_sendfile=>true
	end

	def pdf_to_ppt
		@user = User.first
	end

	def do_pdf_to_ppt
		@user = User.create(pdf: params[:pdf])

		@path_in = @user.pdf.path

		temp1 = @user.pdf.path

		@path_out = temp1.slice(0..temp1.rindex(/\//))

		query = "cd "+@path_out+" && libreoffice --invisible --convert-to ppt " + @user.pdf.original_filename

		system (query)

		@rendered = @path_out + @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1) + '.ppt'

		send_file @rendered, :type=>"application/vnd.openxmlformats-officedocument.presentationml.presentation", :x_sendfile=>true
	end


	def ppt_to_pdf
		@user = User.first
	end

	def do_ppt_to_pdf
		@user=User.create(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
		query = "cd "+@path_out+" && unoconv -f pdf "+@user.pdf.original_filename
		system(query)
		file = @path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"
		send_file file, :type=>"application/pdf", :x_sendfile=>true
	end

	
	def split_pdf
		@user = User.first
	end

	def do_split_pdf
		@user=User.create(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//)) + 'output/'
		query = "docsplit pages " + @path_in + " -o " + @path_out
		temp2 = @user.pdf.url
		@relative_path = temp2.slice(0..temp2.rindex(/\//)) + 'output/'
		system(query)
		FileUtils.rm(Rails.root.to_s + '/public'+@relative_path+'doc_data.txt')
		system('cd '+temp1.slice(0..temp1.rindex(/\//)) + ' && zip -r splitted_pdfs.zip output')
		zipped = temp1.slice(0..temp1.rindex(/\//)) + 'splitted_pdfs.zip'
		send_file zipped, :type=>"application/zip", :x_sendfile=>true
	end

	def compress_pdf
		@user = User.first
	end

	def do_compress_pdf
		@user=User.create(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
		query = "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH  -dQUIET -sOutputFile="+@path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+"_compressed.pdf "+@path_in
		system(query)
		compressed = temp1.slice(0..temp1.rindex(/\//)) + @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+"_compressed.pdf"
		send_file compressed, :type=>"application/pdf", :x_sendfile=>true
	end

	def jpg_to_pdf
		@user = User.first
	end

	def do_jpg_to_pdf
		@user=User.create(pdf: params[:pdf])

		@path_in = @user.pdf.path

		temp1 = @user.pdf.path

		@path_out = temp1.slice(0..temp1.rindex(/\//))

		query = "convert "+@path_in+" "+@path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"

		system(query)

		file = temp1.slice(0..temp1.rindex(/\//)) + @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"

		send_file file, :type=>"application/pdf", :x_sendfile=>true
	end

	def unlock_pdf
		@user = User.first
	end

	def do_unlock_pdf
		@user=User.create(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
		query = "cd "+@path_out+" && qpdf --decrypt "+@user.pdf.original_filename+" "+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+"_unlocked.pdf"
		system(query)
		file = temp1.slice(0..temp1.rindex(/\//)) + @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+"_unlocked.pdf"
		send_file file, :type=>"application/pdf", :x_sendfile=>true
	end

	def watermark_pdf
		@user = User.first
	end

	def ask_watermark
		@user=User.create(pdf: params[:pdf])
		session[:user_id] = @user.id
	end

	def do_watermark_image
		uploaded_io = params[:picture]
		img = uploaded_io.path
		@user = User.find(session[:user_id])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//)) + 'output_pngs/'
		Docsplit.extract_images(@path_in, {output: @path_out})
		temp2 = @user.pdf.url
		@relative_path = temp2.slice(0..temp2.rindex(/\//)) + 'output_pngs/'
		@images = Dir.entries(Rails.root.to_s + '/public'+@relative_path).reject {|f| File.directory?(f) || f[0].include?('.')}
		filename = @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)
		@images.each do |image|
			system('cd '+@path_out+'&& composite -dissolve '+params[:transparency]+' -gravity '+params[:position]+' '+img+' '+@path_out+image+' '+image)
		end
		i=1
		query='convert'
		while i <= @images.size  do
			query=query+' '+filename+'_'+i.to_s+'.png '
			i +=1
		end
		query=query+@user.pdf.original_filename
		system('cd '+@path_out+'&& '+query)
		file = @path_out+@user.pdf.original_filename
		send_file file, :type=>"application/pdf", :x_sendfile=>true
	end
	
	

end