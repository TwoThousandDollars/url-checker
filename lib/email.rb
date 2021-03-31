# require_relative "url"
require_relative "url_module.rb"
require 'dir'
require 'mail'

class NationwideEmail
include Url
    attr_accessor   :email_path, 
                    :full_audience_segment, 
                    :main_entity_name, 
                    :module_1, 
                    :module_2, 
                    :subject_line, 
                    :matrix_urls, 
                    :final_urls

    def initialize(email_path)

        # TODO()
        # find a way to cut an array in half since there is a mobile url and a desktop url for each email
        # solution can be found here: /home/bbrooks/Documents/TOP/test_programs/filters_mobile_and_desktop_url.rb
        
        @email_path = email_path

        @text_content = Mail.read(@email_path).text_part.decoded
        
        @full_audience_segment = get_full_audience_segment(@email_path)
        
        @main_entity_name = @full_audience_segment[0]
        
        @module_1 = @full_audience_segment[1]
        
        @module_2 = @full_audience_segment[2]

        @subject_line = @full_audience_segment[3]
        
        @matrix_urls = get_matrix_urls

        @test_urls = ["https://click.email-nationwide.com/open.aspx?ffcb10-fec710797765067b-fe551075706c0c7d7211-fe5a15707d61027c721d-ff961677-fe5710777662037e7310-ffca11&d=10144&bmt=0", "http://view.email-nationwide.com/?qs=b2eb43bbd5335312121167078a25172786466ed565026d3efc6ca21777c762755e5e9aaa8a95f53f4de7027c023d006bd3c6036f57c40da21b8ccc6f675cab2ad5422cbaeab64850", "https://pages-nationwide.com/page.aspx?qs=38dfbe491fab00ead2030f3988587c818ef9e800f598fdb142b9dca88448827a400c76c677848a116eea9f7cc13b3bdcae464a658613fcea93bf5e019c395df5145ee1d4ae179cd0367d6ea142c439d63081e22e0ecfeb295108d1f007238e4fc8e329686e24059291ab66c4b51b93e342704e1abd4457212b8dbbbce55a5fcbebc71e9c83e57336389edc5d11269b512b2ffeef681805689ade31bc8d432134284e60b73588c688118025eb7d36be3a0a32332770660f369b26d68a8beac0bd8b3ffe033b1937045c3bb095b312f7d857afa64dc9794bcc", "https://www.finra.org/?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://pages-nationwide.com/page.aspx?qs=38dfbe491fab00ead2030f3988587c818ef9e800f598fdb142b9dca88448827a400c76c677848a116eea9f7cc13b3bdcae464a658613fcea93bf5e019c395df5145ee1d4ae179cd0367d6ea142c439d63081e22e0ecfeb295108d1f007238e4fc8e329686e24059291ab66c4b51b93e342704e1abd4457212b8dbbbce55a5fcbebc71e9c83e57336389edc5d11269b512b2ffeef681805689ade31bc8d432134284e60b73588c688118025eb7d36be3a0a32332770660f369b26d68a8beac0bd8b3ffe033b1937045c3bb095b312f7d857afa64dc9794bcc", "http://view.email-nationwide.com/?qs=b2eb43bbd5335312121167078a25172786466ed565026d3efc6ca21777c762755e5e9aaa8a95f53f4de7027c023d006bd3c6036f57c40da21b8ccc6f675cab2ad5422cbaeab64850", "https://www.nrsforu.com/rsc-web-preauth/index.html", "https://www.finra.org/?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.nrsforu.com/rsc-web-preauth/index.html", "https://www.facebook.com/nationwide?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://twitter.com/nationwide?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://twitter.com/nationwide?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.facebook.com/nationwide?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "", "https://checkappointments.net/appts/5jrQfKGEir?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.caring.com/", "https://blog.nationwide.com/who-to-name-in-a-will/?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://blog.nationwide.com/who-to-name-in-a-will/?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.caring.com/", "https://www.mythorntonretirement.com/rsc-web-preauth/about-to-retire/articles/stay-in-your-plan.html?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.mythorntonretirement.com/rsc-web-preauth/about-to-retire/articles/stay-in-your-plan.html?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364"].sort!
        
        # @final_urls = get_final_urls(@text_content).sort!

    end

    
    private

    def get_matrix_urls 
        fetch_urls_from_matrix(@main_entity_name, @module_1, @module_2)
    end

    def get_full_audience_segment(email_file_name)
        audience_array = email_file_name.split(/\-MainEntity\-|\-M\d\-|\-proof\]\s/)
        audience_array.slice! 0
        audience_array.first(3).each do |i| 
            i.downcase!
            i.tr!(" ", "_")
        end
        audience_array[3].slice! ".eml"
        return audience_array
    end


end