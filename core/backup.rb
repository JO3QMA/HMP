# frozen_string_literal: true

require 'fileutils'
require 'zip'

# バックアップ処理
class Backup
  def initialize
    # 初期化
    @logger = SingletonLogger.instance
  end

  def copy(source, target, _ignore = nil)
    FileUtils.cp_r(source, target)
  end

  def copy_tmp(source, target, name, ignore = nil)
    # 一時ディレクトリーにコピー
    target = File.join(target, name)
    @logger.info("#{source}を#{target}にコピーします。")
    #FileUtils.mkdir(target)
    copy(source, target, ignore)
  end

  def remove(target, _keep)
    FileUtils.rm_r(target)
  end

  def compress(target, format); end
end
