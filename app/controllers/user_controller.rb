class UserController < ApplicationController
	include ExtractImages
	require 'rubygems'
	require 'pdf/reader'
	require 'curb'
	require 'rest-client'
	require 'json'
	require 'roo'
	def pdf_to_jpg
		@user = User.first
	end

	def do_pdf_to_jpg
		@user=User.create!(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//)) + 'output/'
		Docsplit.extract_images(@path_in, {output: @path_out, :format => [:png,:jpg]})
		temp2 = @user.pdf.url
		@relative_path = temp2.slice(0..temp2.rindex(/\//)) + 'output/'
		@images = Dir.entries(Rails.root.to_s + '/public'+@relative_path).reject {|f| File.directory?(f) || f[0].include?('.')}
		system('cd '+temp1.slice(0..temp1.rindex(/\//)) + ' && zip -r images.zip output')
		zipped = temp1.slice(0..temp1.rindex(/\//)) + 'images.zip'
		send_file zipped, :type=>"application/zip", :x_sendfile=>true
	end

	def word_to_pdf
		@user = User.first
	end

	def do_word_to_pdf
		@user=User.create!(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//)) + 'output/'
		Docsplit.extract_pdf(@path_in, {output: @path_out})
		@filename = @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)
		@rendered = @path_out + @filename + '.pdf'
		send_file @rendered, :type=>"application/pdf", :x_sendfile=>true
	end

	def pdf_to_word
		@user = User.first
	end

	def do_pdf_to_word
		@user = User.create!(pdf: params[:pdf])
		@path = @user.pdf.path
		@path_out = @user.pdf.path.slice(0..@user.pdf.path.rindex(/\//))
		query = "libreoffice --headless --invisible --convert-to doc " + @path + " --outdir " + @path_out
                # query = "abiword --to=doc " + @path
		system (query)
		@filename = @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)
		@rendered = @path_out + @filename + '.doc'
		send_file @rendered, :type=>"application/msword", :x_sendfile=>true
	end

	def excel_to_pdf
		@user = User.first
	end

	def do_excel_to_pdf
		# @user=User.create!(pdf: params[:pdf])
		# @path_in = @user.pdf.path
		# temp1 = @user.pdf.path
		# @path_out = temp1.slice(0..temp1.rindex(/\//))
		# query = "cd "+@path_out+" && unoconv -d document --format=pdf "+@user.pdf.original_filename
		# system(query)
		# file = @path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"
		# send_file file, :type=>"application/pdf", :x_sendfile=>true

		@user=User.create!(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = @user.pdf.path.slice(0..@user.pdf.path.rindex(/\//))
		query = "libreoffice --headless --invisible --convert-to pdf " + @path_in + " --outdir " + @path_out
		system(query)
		file = @path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"
		send_file file, :type=>"application/msexcel", :x_sendfile=>true
	end

	# pdf to excel
	def pdf_to_excel
		@user = User.first
	end

	def do_pdf_to_excel
		@user=User.create!(pdf: params[:pdf])
		@path_in = @user.pdf.path
		path_out = @path_in.slice(0..@path_in.rindex(/\//))
		filename = path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)
			
		#======================================


		# request = RestClient::Request.new(
  #         :method => :post,
  #         :url => 'https://pdftables.com/api?key=n6guorlcb7hm&format=xlsx-single',
  #         :payload => {
  #           :multipart => true,
  #           :file => File.new("#{@path_in}", 'r')
  #         })      
		# response = request.execute
		# response_data = JSON.parse(response.body)

		# c = Curl::Easy.http_post("https://pdftables.com/api?key=n6guorlcb7hm&format=xlsx-single",Curl::PostField.content('thing[file]', @path_in))
		# c.multipart_form_post = true
		# c.http_post(Curl::PostField.file('thing[file]', @path_in))
		#/home/viinfo/Downloads/first.pdf
		
		text_arry = []
		reader = PDF::Reader.new(@user.pdf.path) 
		reader.pages.each do |page|
			raise page.inspect
	    file_text_arr = text_arry.push(page.text)
	    file_text_arr.each do |text|
	    	@valid_file_data = text.split("\n").reject{|c| c.empty?}
	    end
	    File.open("#{filename}.xls", "w+") do |f|
				f.puts @valid_file_data
			end
	  end
	  rendered  = filename.concat('.xls')
	  send_file rendered, :type=>"application/msexcel", :x_sendfile=>true
	end

	def pdf_to_ppt
		@user = User.first
	end

	def do_pdf_to_ppt
		@user = User.create!(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
		query = "cd "+@path_out+" && libreoffice --invisible --convert-to ppt " + @user.pdf.original_filename
		system (query)
		@rendered = @path_out + @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1) + '.ppt'
		send_file @rendered, :type=>"application/mspowerpoint", :x_sendfile=>true
	end


	def ppt_to_pdf
		@user = User.first
	end

	def do_ppt_to_pdf
		@user=User.create!(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
 		# query = "cd "+@path_out+" && unoconv -f pdf "+ @user.pdf.original_filename
 		query = "cd "+@path_out+" && libreoffice --headless --invisible --convert-to pdf " + @user.pdf.original_filename
		system (query)
	 	file = @path_out + @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"
		send_file file, :type=>"application/pdf", :x_sendfile=>true
	end

	def split_pdf
		@user = User.first
	end

	def do_split_pdf
		@user=User.create!(pdf: params[:pdf])
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
		@user=User.create!(pdf: params[:pdf])
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
          #begin
		@user=User.create!(pdf: params[:pdf])
		@path_in = @user.pdf.path
		temp1 = @user.pdf.path
		@path_out = temp1.slice(0..temp1.rindex(/\//))
		query = "convert "+@path_in+" "+@path_out+@user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"
		system(query)
		file = temp1.slice(0..temp1.rindex(/\//)) + @user.pdf.original_filename.slice(0..@user.pdf.original_filename.rindex('.')-1)+".pdf"
		send_file file, :type=>"application/pdf", :x_sendfile=>true
          #rescue Exception => e
	   # return render text: e.inspect
	  #end
	end

	def unlock_pdf
		@user = User.first
	end

	def do_unlock_pdf
		@user=User.create!(pdf: params[:pdf])
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
		@user=User.create!(pdf: params[:pdf])
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

	def merge_pdf
		@user = User.first
	end

	def do_merge_pdf
		if params[:pdf].present?
			all_pdf_files = true 
			params[:pdf].each do |pdf|
				unless pdf.content_type == "application/pdf"
					all_pdf_files = false
				end
			end
			if all_pdf_files
				pdf_arr = []
				params[:pdf].each{|pdf| pdf_arr << User.create!(pdf: pdf)}
				query = ''
				pdf_arr.each do |p|
					query += p.pdf.path + " "
				end
				temp1 = pdf_arr[0].pdf.path
				@path_out = temp1.slice(0..temp1.rindex(/\//)) + 'merged.pdf'
				query = "pdftk " + query + "output " + @path_out
				system(query)
			end
			begin
				send_file @path_out, :type=>"application/zip", :x_sendfile=>true
			rescue
				flash[:notice] = "Could not merge pdf files. Make sure you have selected only pdf files"
				redirect_to user_merge_pdf_url
			end
		else
			flash[:notice] = "You have not selected any pdf files."
			redirect_to user_merge_pdf_url
		end
	end

end
