Lita.configure do |config|
  
#config.robot.adapter = :slack
  #config.adapters.slack.token = "xoxb-4536110369255-4553117322836-7fd7Lpl09EyHuP5vwFmYiMQQ"
  # The name your robot will use.
  config.robot.name = "mybot"

  # The locale code for the language to use.
  # config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :info

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.
  # config.robot.admins = ["1", "2"]

 # The adapter you want to connect with. Make sure you've added the
# appropriate gem to the Gemfile. 
# heroku uses a RACK_ENV of 'production' by default
#	if ENV['RACK_ENV'] == 'production' 
#		config.robot.adapter = :slack
#		config.redis[:url] = ENV.fetch('REDIS_URL')
#	else
#		config.robot.adapter = :shell
#	end
# slack adapter demands a value even in dev when we aren't using it... 
	
end


  ## Example: Set options for the chosen adapter.
  # config.adapter.username = "myname"
  # config.adapter.password = "secret"

  ## Example: Set options for the Redis connection.
  # config.redis.host = "127.0.0.1"
  # config.redis.port = 1234

  ## Example: Set configuration for any loaded handlers. See the handler's
  ## documentation for options.
  # config.handlers.some_handler.some_config_key = "value"
