require_relative "email_parser"

class Email
    def initialize(urls)
        
        @full_audience_segment = get_full_audience_segment
        
        @main_entity_name = @full_audience_segment[0]
        
        @module_1 = @full_audience_segment[1]
        
        @module_2 = @full_audience_segment[2]
        
        @urls = urls
        
    end

    private

    def get_full_audience_segment
        return [1,2,3]
    end
end