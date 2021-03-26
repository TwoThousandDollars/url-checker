require 'csv'
require 'pp'

MATRIX = 'csv/url_matrix.csv'
TRANSPOSED_MATRIX = 'csv/url_matrix_transposed.csv'

column_headers = CSV.open(TRANSPOSED_MATRIX, headers: true, header_converters: :symbol).read.headers

email_versions = {}

CSV.foreach(TRANSPOSED_MATRIX).with_index do |row, row_num|
    
    secondary_type = row[0]
    
    unless secondary_type.downcase.include? "url"
        next
    end
    
    segment_parts = secondary_type.split("_")
    secondary_segment = segment_parts[1]
    url_type = segment_parts[2]

    column_headers.each_with_index do |main_entity, col_num|

        # initializes segment name
        if email_versions[main_entity].nil?
            email_versions[main_entity] = { secondary_segment => nil }
        end

        if email_versions[main_entity][secondary_segment].nil?
            email_versions[main_entity][secondary_segment] = { url_type => row[col_num] }
        
        elsif !email_versions[main_entity][secondary_segment].has_key? url_type
            email_versions[main_entity][secondary_segment].merge!(url_type => row[col_num])
        end

    end

end
p column_headers[1]
pp email_versions[column_headers[1]]




# {
#     main_entity_name: {
#         audience_segment: {
#             module_1: {
#                 url_1: ___,
#                 url_2: ___
#             }

#             module_2: {
#                 url: ___
#             }
#         }
#     }
# }