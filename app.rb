#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "<h3>Добро пожаловать на наш интернет салон Barber Shop</h3>"
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datatime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}."
end

if @username==''
	@error='Ошибка: Введите имя!'
	return erb :index
end

#if @error !=''
#	return erb :index
#end