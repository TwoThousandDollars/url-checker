require_relative "url_module"
require_relative "email"
require_relative "url_matrix_checker"
require 'dir'

PATH_TO_EMAILS = './email/'

all_emails = Dir["#{PATH_TO_EMAILS}*.eml"]

email = NationwideEmail.new(all_emails[0])

puts email.matrix_urls