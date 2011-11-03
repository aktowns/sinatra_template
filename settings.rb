set :public_folder, File.dirname(__FILE__) + '/static'

configure do
	# Change the environment here
	set :environment, :development

	DataMapper::Logger.new($stdout, :debug)
	enable  :sessions, :logging
end

configure :development do
	require 'dm-sqlite-adapter'

	DataMapper.setup(:default, "sqlite://#{File.expand_path(File.dirname(__FILE__))}/project.db")

	# load our models
	Dir["models/**"].each { |file| require File.expand_path("../#{file}" , __FILE__) }
	DataMapper.finalize
	DataMapper.auto_migrate! 	# This will clear the development database on restart of the
								# app, change to auto_upgrade! to attempt to seamlessly upgrade

	# load our db seed
	require File.expand_path("../seed.rb", __FILE__)
end

configure :production do
	disable :show_exceptions

	set :bind, '0.0.0.0'
	set :port, 80

	throw "Database not configured for production"
	#DataMapper.setup(:default, 'mysql://localhost/the_database_name')
	#DataMapper.setup(:default, 'postgres://localhost/the_database_name')

	# load our models
	Dir["models/**"].each { |file| require File.expand_path("../#{file}" , __FILE__) }
	DataMapper.finalize
	DataMapper.auto_upgrade!

	# load our db seed
	require File.expand_path("../seed.rb", __FILE__)
end