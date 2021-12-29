# frozen_string_literal: true

require 'logger'
require 'singleton'

# Logger
class SingletonLogger < Logger
  LOGFILE = 'log.log'
  LOGLEVEL = Logger::Severity::INFO

  include Singleton

  def initialize(log_dir = './log')
    log_path = File.join(log_dir, LOGFILE)
    super(log_path, level: LOGLEVEL)
  end
end
