require 'sinatra'
require 'sendgrid-ruby'

#localhost 4567

get '/' do
  "Kings Bounty"
end

get '/home' do
  erb :home
end

get '/about' do
  erb :about
end

get '/music' do
  erb :music
end

get '/shows' do
  erb :shows
end

get '/photos' do
  erb :photos
end

get '/store' do
  erb :store
end

get '/contact' do
  erb :contact
end




# sendgrib API email setup
get '/home' do

  # set the from, subject and to addresses
  from    =   SendGrid::Email.new(email: @from_email)
  to      =   SendGrid::Email.new(email: 'KingsBounty27@gmail.com')
  subject =   @subject

  # set the content to send in the email
  content = SendGrid::Content.new(type: 'text/plain', value: @content)

  # set the mail attribute values
  mail = SendGrid::Mail.new(from, subject, to, content)

  # pass in the sendgrid api key
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

  # send the email
  response = sg.client.mail._('send').post(request_body: mail.to_json)

  # display the response status code and body in terminal
  puts "STATUS CODE", response.status_code
  puts "", response.body

end # ends sendgrid email


get '/contact_us' do
  erb :contact_form
end

post '/send_dynamic_email' do

  puts params.inspect

  # {
  #   "from_email"=>"steve.licata@gmail.com",
  #   "to_email"=>"steve.licata@gmail.com",
  #   "email_subject"=>"hi"
  #   "email_content"=>"lorem"
  # }

#set variables to hold parameter data:
@from_email = params[:from_email]
@to_email = "KingsBounty27@gmail.com"
@email_subject = params[:email_subject]
@email_content = params[:email_content]

# set the 'from', 'subject' and 'to' addresses
from = SendGrid::Email.new(email: @from_email)
to = SendGrid::Email.new(email: @to_email)
subject = @email_subject

# set the content to send in the email
content =  SendGrid::Content.new(type: 'text/plain', value: @email_content)

# set the mail attribute values
mail = SendGrid::Mail.new(from, subject, to, content)

# pass in the sendgrid api key
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

# send the email
response = sg.client.mail._('send').post(request_body: mail.to_json)

# display the response status code and body
puts "STATUS CODE:", response.status_code
puts "resonse.body:", response.body

  if response.status_code.to_i == 202
    redirect '/success'
  else
    redirect '/fail'
  end

end

get '/success' do
  erb :success
end

get '/fail' do
  "There was a problem and your request was not processed successfully...please try again"
end
