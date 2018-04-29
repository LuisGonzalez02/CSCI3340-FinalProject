require 'twilio-ruby'

# Get your Account Sid and Auth Token from twilio.com/console
account_sid = 'AC3040bfd66e0c15eeae03e6b7bd55443c'
auth_token = 'a10018bf4cfb66aa234e84b45960c3f5'

# set up a client to talk to the Twilio REST API
client = Twilio::REST::Client.new account_sid, auth_token


to = "+19563523539"
from = "+12019928984"

client.messages.create(
from: from,
to: to,
body: "Hey, its me dio!"
)