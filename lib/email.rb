require_relative "email_parser"

class Email
    def initialize(email_path, urls)

        # TODO()
        # CREATE AN EMAIL OBJECT AND TEST THAT IT CAN PROPERLY EXTRACT AUDIENCE INFO FROM SL
        
        @full_audience_segment = get_full_audience_segment
        
        @main_entity_name = @full_audience_segment[0]
        
        @module_1 = @full_audience_segment[1]
        
        @module_2 = @full_audience_segment[2]

        @subject_line = @full_audience_segment[3]
        
        @urls = urls

    end

    private

    def get_full_audience_segment(email_file_name, audience_array=[])
        audience_array = email_file_name.split(/\-MainEntity\-|\-M\d\-|\-proof\]\s/).slice! 0
        audience_array.each {|i| i.downcase! }
    end


end