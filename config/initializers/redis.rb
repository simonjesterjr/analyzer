# frozen_string_literal: true

# Rails, Puma, Redis, and Connection Pool
# https://stackoverflow.com/questions/29942245/ruby-on-rails-puma-on-worker-boot-connect-with-redis
# https://stackoverflow.com/questions/28113940/what-is-the-best-way-to-use-redis-in-a-multi-threaded-rails-environment-puma?noredirect=1
# https://stackoverflow.com/questions/31810396/rails-puma-running-out-of-redis-connections
redis_connection = Redis.new( url: "#{ENV['REDIS_URI']}", db: 0 )
$redis = ConnectionPool.new( size: 5, timeout: 5 ) { redis_connection }
