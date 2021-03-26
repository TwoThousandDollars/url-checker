require 'mail'
require 'dir'
require 'uri'
require 'net/http'
require 'final_redirect_url'
require 'thread'  # for Mutex

PATH_TO_EMAILS = './email/'
BLOCKED_URL_TYPES = ['.png', '.gif', '.jpg', 'pixel.monitor']
THREAD_COUNT = 5  # tweak this number for maximum performance.

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

def fetch_url(url)
    FinalRedirectUrl.final_redirect_url(url)
end

def get_final_redirected_urls(urls, redirects=[], mutex = Mutex.new)
    
    THREAD_COUNT.times.map {
        Thread.new(urls, redirects) do |urls, redirects|
            while url = mutex.synchronize { urls.pop }
                redirect = fetch_url(url)
                mutex.synchronize { redirects << redirect }
            end
        end
    }.each(&:join)

    return redirects

end

all_emails = Dir["#{PATH_TO_EMAILS}*.eml"]

email = Mail.read(all_emails[6]).text_part.decoded

File.open('taxi_test.html', "w") { |f| f.write(email) }


final_redirected_urls = ["https://click.email-nationwide.com/open.aspx?ffcb10-fec610797462007c-fe551075706c0c7d7211-fe5a15707d61027c721d-ff961677-fe5710777662037e7310-ff981774&d=10142&bmt=0", "https://pages-nationwide.com/page.aspx?qs=38dfbe491fab00ead2030f3988587c818ef9e800f598fdb142b9dca88448827ac6b2812807536a1fda3dd3cf8352f0aa0e1c8fa12367addac80aeb8929206f9dd9f2eab18ba18d00d5467f5e650dee2f14f9d6759dc270372b10d760720b3ddfb7bbe13b4165ca20436ed79f4fb0ff8178c614a1b5646cfffa8ddef0271bf2d0c74ed19ed714b3e9646cd894cfa4720b259d304ebf307fda583de01de3d942d7cf99890ebeff38eae0f97efb79defe40bc014b9935861f4ad76c55e8efc023b47fc3e29b352813d07941029a2174122b155574272124c58a", "https://www.finra.org/?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=491641.47367364&WT.dcsvid=47367364", "https://twitter.com/nationwide?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=491641.47367364&WT.dcsvid=47367364", "https://play.google.com/store/apps/details?id=com.nationwide.myretirement&utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=491641.47367364&WT.dcsvid=47367364", "https://www.nrsforu.com/rsc-web-preauth/privacy/index.html", "https://www.facebook.com/nationwide?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=491641.47367364&WT.dcsvid=47367364", "https://search.itunes.apple.com/WebObjects/MZContentLink.woa/wa/link?mt=8&path=apps%2fmyretirement?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=491641.47367364&WT.dcsvid=47367364", "https://checkappointments.net/appts/5jrQfKGEir?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=491641.47367364&WT.dcsvid=47367364", "https://www.caring.com/", "https://blog.nationwide.com/who-to-name-in-a-will/?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=491641.47367364&WT.dcsvid=47367364", "http://view.email-nationwide.com/?qs=a13ca4313424f6b315c33ec80df2ecefa6d8d9b01c172dffc58fcc8f244e5be08e08ff4a0607935750d1d953794e3cc6c8128fac388ab3e0ac1795aa96d6dbb1acac501596275cb9f15a5abeb78cd867", "https://www.chicagodeferredcomp.com/iApp/tcm/chicagodeferredcomp/learning/library/some_benefits_of_consolidation.jsp?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=491641.47367364&WT.dcsvid=47367364"]

# get_final_redirected_urls(clean_urls)



# p first_redirect.class


# dirty_urls = URI.extract(email.parts[0].decoded, ['http', 'https']).select { |url| !BLOCKED_URL_TYPES.include? url }

# clean_urls = filter_dirty_urls(dirty_urls)