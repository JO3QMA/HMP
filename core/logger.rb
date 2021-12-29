# frozen_string_literal: true

require 'logger'
require 'singleton'

# Logger
class SingletonLogger < Logger
  LOGFILE = 'log.log'
  LOGLEVEL = Logger::Severity::INFO

  include Singleton

  def initialize(log_dir = './log')
    super(File.join(log_dir, LOGFILE), level: LOGLEVEL)
  end
end
