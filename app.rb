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

	hh = { :username =>'Ошибка: Введите имя!', 
		   :phone => 'Ошибка: Введите номер телефона!',
		   :datetime => 'Ошибка: Введите время и дату!'}

	## для каждой пары ключ-значение
	#hh.each do |key, value|
	#	#если параметр пуст, то присвоить error - value из хеша hh,
	#	#а value из хеша hh это сообщение об ошибке 
	#	# т.е. переменной error присвоить сообщение об ошибке
	#	if params[key] ==''
	#		@error = hh[key]
	#	return erb :visit
	#	end
	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error !=''
		return erb :visit
	end

erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}."

end