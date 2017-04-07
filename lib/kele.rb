require 'httparty'
require 'json'

class Kele
  include HTTParty
  BASE_URI = 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @email = email
    @password = password
  end

  def get_me
    options = { body: { email: @email, password: @password } }
    response = self.class.post(BASE_URI + '/sessions', options)
    @auth_token = response['auth_token']
  end

  def get_mee
    options = { headers: { "authorization" => @auth_token } }
    response_current_user = self.class.get(BASE_URI + '/users/me', options)
  end

  def get_mentor_availability( mentor_id )
    options = { headers: { "authorization" => @auth_token } }
    response = self.class.get(BASE_URI + '/mentors/' + mentor_id.to_s + '/student_availability', options)
  end
end
