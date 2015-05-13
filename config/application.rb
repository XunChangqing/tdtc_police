require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TdtcPolice
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = "Beijing"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = "zh-cn"

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "http://localhost:3000/"
)

#enable detailed CAS logging
#cas_logger = CASClient::Logger.new(::Rails.root+'/log/cas.log')
#cas_logger.level = Logger::DEBUG

#CASClient::Frameworks::Rails::Filter.configure(
  #:cas_base_url  => "https://cas.example.foo/",
  #:login_url     => "https://cas.example.foo/login",
  #:logout_url    => "https://cas.example.foo/logout",
  #:validate_url  => "https://cas.example.foo/proxyValidate",
  #:username_session_key => :cas_user,
  #:extra_attributes_session_key => :cas_extra_attributes,
  #:logger => cas_logger,
  #:enable_single_sign_out => true
  #:service_url => "https://mysite.service.com"
#)
