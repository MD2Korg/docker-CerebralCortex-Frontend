WaterDrop.setup do |config|
  config.send_messages = true
  config.connection_pool_size = 20
  config.connection_pool_timeout = 1
  config.kafka_hosts = [Rails.env.production? ? 'tatooine10dot:9092' : 'localhost:9092']
  config.raise_on_failure = Rails.env.production?
end