require 'rubygems'
require 'sequel'
require 'sinatra'
require 'json'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  DB = Sequel.connect(ENV['HEROKU_POSTGRESQL_GREEN_URL'] || 'postgres://localhost/webhooks')
end

require './deployment'
require './alert'

get '/' do
  @deployments = Deployment.order(:created_at.desc)
  @alerts = Alert.order(:created_at.desc)
  erb :index
end

post '/webhook' do
  if params[:deployment]
    deployment = Deployment.new(JSON.parse(params[:deployment]))
    deployment.save
  end
  if params[:alert]
    alert = Alert.new(JSON.parse(params[:alert]))
    alert.save
  end
  status 200
end
