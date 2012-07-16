IMGKit.configure do |config|
  config.wkhtmltoimage = '/home/credvine/bin/wkhtmltoimage'
  config.default_options = {
    :quality => 100
  }
  config.default_format = :png
end