require 'httmultiparty'
  class PageTextReceiver
    include HTTMultiParty
    base_uri 'http://localhost:3000'

    def run
      response = PageTextReceiver.post('https://pdftables.com/api?key=n6guorlcb7hm', :query => { f: File.new("/home/viinfo/Downloads/exaam.pdf", "r") })

      File.open('public/response.html', 'w') do |f|
        f.puts response
      end
    end
    # def convert
  #   f = File.open("public/response.html")
  #   doc = Nokogiri::HTML(f)
  #   csv = CSV.open("path/to/csv/t.csv", 'w',{:col_sep => ",", :quote_char => '\'', :force_quotes => true})
  #   doc.xpath('//table/tr').each do |row|
  #     tarray = []
  #     row.xpath('td').each do |cell|
  #       tarray << cell.text
  #     end
  #     csv << tarray
  #   end
  #   csv.close
  # end
end