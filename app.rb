require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'pg'
# require 'pry'

# Load the file to connect to the DB
require_relative 'db/connection'


# Load models
require_relative 'models/pokemon'

get '/' do
  redirect '/pokemons'
end

# List out all pokemons
get '/pokemons' do
  @pokemons = Pokemon.all
  erb :"pokemons/index"
end

# generating a new view w a form which
# contains ability to create
get '/pokemons/new' do
  erb :"pokemons/new"
end

get '/pokemons/:id' do
  @pokemon = Pokemon.find(params[:id])
  erb :"pokemons/show"
end

# this path needs to be the same as the action of the form that's making the request, in new.erb
post '/pokemons' do 
  @pokemon = Pokemon.create(name: params[:name], poke_type: params[:poke_type], cp: params[:cp], img_url: params[:img_url])
end

# form here allows you to render the form to make the update request below
get '/pokemons/:id/edit' do
  @pokemon=Pokemon.find(params[:id])
  erb :"pokemons/edit"
end

# this path needs to be the same as the action of the form that's making the request, in edit.erb
put '/pokemons/:id' do
  @pokemon = Pokemon.find(params[:id])
  @pokemon.update(params[:pokemon])
  redirect "/pokemons #{pokemon.id}"
end

delete '/pokemon/:id' do
  pokemon = Pokemon.find(params[:id])
  pokemon.destroy
  redirect "/pokemons"
end

# binding.pry
# puts "end"
