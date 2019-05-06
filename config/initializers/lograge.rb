Rails.application.configure do
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.enabled = true
end
