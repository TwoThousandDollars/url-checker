require 'csv'

transposed = CSV.read('url_matrix.csv').transpose

CSV.open("url_matrix_transposed.csv", 'w') do |csv|
    transposed.each do |row|
        csv << row
    end
end

url_matrix = CSV.open 'url_matrix_transposed.csv', headers: true, header_converters: :symbol

column_headers = url_matrix.read.headers

url_matrix = CSV.open 'url_matrix_transposed.csv', headers: true, header_converters: :symbol

url_type = []

url_matrix.drop(1).each do |row|
    url_type << row[0] if row[0].downcase.include? "url"
end

puts url_type