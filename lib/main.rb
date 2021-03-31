require_relative "url_module"
require_relative "email"
require_relative "url_matrix_checker"
require 'dir'

PATH_TO_EMAILS = './email/'

all_emails = Dir["#{PATH_TO_EMAILS}*.eml"]

email = NationwideEmail.new(all_emails[2])

# p email.final_urls

urls = ["http://view.email-nationwide.com/?qs=b2eb43bbd5335312121167078a25172786466ed565026d3efc6ca21777c762755e5e9aaa8a95f53f4de7027c023d006b0a6badd11e2c1a3f93229aaa1705f2e7a23449d01c8026f3", "https://pages-nationwide.com/page.aspx?qs=38dfbe491fab00ead2030f3988587c818ef9e800f598fdb142b9dca88448827a400c76c677848a116eea9f7cc13b3bdcae464a658613fcea3184c65bd76ceea9ff6e00dd42076d201d47b97bdaa512abffee968012dffa0b0cf4ee6f0c85c184a1c150463e4e230c6d51907f26a54d307836d70f1e292abad0430d83a4fa57184aeb1dd0778711b6c51300a5045fed60a7b2afa1f61e47fb61392da75612d884b5b52d934c4c9ed0ca13587b786c66d3e01549e3497a131a129a3c382d921adb856f774499c190d6e4f5dbdc1e80adc660989950ebbcfcfc", "https://twitter.com/nationwide?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.experian.com/blogs/ask-experian/credit-education/score-basics/?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.facebook.com/nationwide?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.finra.org/?utm_medium=email&utm_campaign=NF&utm_source=exacttarget&utm_content=:na:na:na:na:ERS00221&utm_term=492126.47367364&WT.dcsvid=47367364", "https://www.nrsforu.com/rsc-web-preauth/index.html", "https://www.tulsa457.com/rsc-web-preauth/index.html"]

# p email.final_urls
puts urls