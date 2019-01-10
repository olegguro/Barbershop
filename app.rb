#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
	#создается подключение к БД и ее выполнение
	db = SQLite3::Database.new 'barbershop.db'
	db.execute 'CREATE TABLE IF NOT EXISTS
		"Users"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"username" TEXT,
			"phone" TEXT,
			"datetime" TEXT,
			"barber" TEXT,
			"color" TEXT
			)'	
end

get '/' do
	erb "<h3>Добро пожаловать на наш интернет салон Barber Shop</h3>"
end

get '/about' do
	@error = 'Страница находится в разработке'
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

	hh = { :username =>'Введите имя!', 
		   :phone => 'Введите номер телефона!',
		   :datetime => 'Введите время и дату!'}

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

erb "Благодарим Вас, мы записали Вас #{@username}, #{@phone}, на #{@datetime},
Ваш парикмахер #{@barber}, цвет окраски #{@color}."

end