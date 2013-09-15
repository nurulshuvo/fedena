PROJECT_ROOT     = File.expand_path(File.join(File.dirname(__FILE__), '..', '..')).freeze
TEMP_ROOT        = File.join(PROJECT_ROOT, 'tmp').freeze
APP_NAME         = 'testapp'.freeze
CUC_Rails.root   = File.join(TEMP_ROOT, APP_NAME).freeze
ENV['RAILS_ENV'] = 'test'
