require 'mail'
require 'dir'
require 'uri'
require 'net/http'
require 'final_redirect_url'

PATH_TO_EMAILS = './email/'
BLOCKED_URL_TYPES = ['.png', '.gif', '.jpg']

def filter_dirty_urls(dirty_urls, clean_urls=[])
    dirty_urls.each do |url|
        test = true
        BLOCKED_URL_TYPES.each do |type|
            if url.include? type
                test = false
            end
        end
        clean_urls << url unless !test
    end
    return clean_urls
end

all_emails = Dir["#{PATH_TO_EMAILS}*.eml"]

email = Mail.read(all_emails[0])

dirty_urls = URI.extract(email.parts[0].decoded, ['http', 'https']).select { |url| !BLOCKED_URL_TYPES.include? url }

clean_urls = filter_dirty_urls(dirty_urls)

first_redirect = FinalRedirectUrl.final_redirect_url(clean_urls[1])

# p first_redirect.class