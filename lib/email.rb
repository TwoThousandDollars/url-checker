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
                    :reference_urls, 
                    :final_urls

    def initialize(email_path)

        # TODO()
        # CREATE AN EMAIL OBJECT AND TEST THAT IT CAN PROPERLY EXTRACT AUDIENCE INFO FROM SL
        
        @email_path = email_path
        
        @full_audience_segment = get_full_audience_segment(@email_path)
        
        @main_entity_name = @full_audience_segment[0]
        
        @module_1 = @full_audience_segment[1]
        
        @module_2 = @full_audience_segment[2]

        @subject_line = @full_audience_segment[3]
        
        @reference_urls = fetch_urls_from_matrix
        @final_urls = ''

    end

    def get_final_urls 

    end

    private

    def get_full_audience_segment(email_file_name)
        audience_array = email_file_name.split(/\-MainEntity\-|\-M\d\-|\-proof\]\s/)
        audience_array.slice! 0
        audience_array.first(3).each {|i| i.downcase! }
        audience_array[3].slice! ".eml"
        return audience_array
    end


end