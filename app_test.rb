require './app'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_view_index
    get '/'
    assert last_response.ok?
  end

  def test_post_deployment_payload
    old = Deployment.all
    deployment = {
      :created_at => "2012-10-17T20:36:02+00:00",
      :application_name => "Application name",
      :account_name => "Account name",
      :changelog => "Changelog for deployment",
      :description => "Information about deployment",
      :revision => "Revision number",
      :deployed_by => "Name of person deploying",
      :version => "1.0"
    }
    post '/webhook', :deployment => deployment.to_json
    assert_equal old.size + 1, Deployment.all.size
    assert last_response.ok?
  end

  def test_post_alert_payload
    old = Alert.all
    alert = {
      :created_at => "2012-10-19T16:55:05+00:00",
      :application_name => "Application name",
      :account_name => "Account name",
      :severity => "Severity",
      :message => "Message about alert",
      :short_description => "Short description about alert",
      :long_description => "Long description about alert",
      :alert_url => "http://PATH_TO_NEW_RELIC",
      :version => "1.0"
    }
    post '/webhook', :alert => alert.to_json
    assert_equal old.size + 1, Alert.all.size
    assert last_response.ok?
  end

end
