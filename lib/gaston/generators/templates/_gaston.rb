# encoding: utf-8
Gaston.configure do |gaston|
  gaston.env = Rails.env
  gaston.files = Dir[Rails.root.join("config/gaston/**/*.yml")]
end
