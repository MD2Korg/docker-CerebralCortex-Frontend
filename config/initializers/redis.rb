$redis = Redis::Namespace.new('cerebralcortex_frontend', :redis => Redis.new(:url => Rails.env.production? ? 'redis://localhost:6379/0' : 'redis://192.168.99.100:6379/0'))