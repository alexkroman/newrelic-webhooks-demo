require 'rubygems'
require 'sinatra'

configure do
    set :public_folder, Proc.new { File.join(root, "static") }
end

get '/' do
  deployment = JSON.parse(params[:deployment])
  erb :index
end
