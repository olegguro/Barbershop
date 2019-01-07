#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "<h3>Добро пожаловать на наш интернет салон Barber Shop</h3>"
end

get '/about' do
	@error = 'something wrong'
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
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	
	if @username == ''
	@error = 'Ошибка: Введите имя!'
	return erb :visit
	end
	
	if @phone == ''
	@error = 'Ошибка: Введите номер телефона!'
	return erb :visit
	end
	
	if @datetime == ''
	@error = 'Ошибка: Неправильная дата и время!'
	return erb :visit
	end
	
	if @barber == ''
	@error = 'Ошибка: Выберите парикмахера!'
	return erb :visit
	end

	if @color == ''
	@error = 'Ошибка: Выберите цвет!'
	return erb :visit
	end

erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}."

end
#if @error !=''
#	return erb :index
#end