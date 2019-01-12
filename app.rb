#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists? db, name
	db.execute('Select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers 
	barbers.each do |barber|
		if !is_barber_exists? db, barber
			db.execute 'Insert into Barbers (name) values (?)', [barber]
		end
	end	 
end

def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
end

before do
	db = get_db
	@barbers = db.execute 'select * from Barbers'
end

#создается подключение к БД и ее выполнение
# код вызывается при инициализации приложения (когда мы изменили код) 
configure do	
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS
		"Users"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"username" TEXT,
			"phone" TEXT,
			"datestamp" TEXT,
			"barber" TEXT,
			"color" TEXT
			)'	
	
	db.execute 'CREATE TABLE IF NOT EXISTS
		"Barbers"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"name" TEXT
			)'	
	seed_db db, ['Jessie Pinkman', 'Walter White', 'Gus Fring', 'John Middle', 
		'Sarah Connor']

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

	#хешcd ~/.ssh
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

	#выполнении БД и ее передача в виде массива
	db = get_db 
	db.execute 'Insert into Users 
	(
		username, 
		phone, 
		datestamp, 
		barber, 
		color
	) 
	values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]

	erb "<h2>Благодарим Вас, Вы записались <h2>"

end

get '/showusers' do
	db = get_db
	
	@results = db.execute 'Select * from Users order by id desc'

	erb :showusers
end