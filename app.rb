require 'rubygems'
require 'sequel'
require 'sinatra'
require 'json'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://development.db')
end

require './deployment'
require './alert'

get '/' do
  @deployments = Deployment.all
  @alerts = Alert.all
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
