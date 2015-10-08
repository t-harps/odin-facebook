class UserMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default from: 'notification@example.com'

  def welcome_email(user)
	@user = user
	@url = 'http://localhost/3000'
	mail(to: @user.email, subject: 'Welcome to Fakebook')
  end
end
