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
    @logger.info("#{source}を#{target}にコピーします。")
    FileUtils.cp_r(source, target)
  end

  def remove(target, _keep = 7)
    FileUtils.rm_r(target)
  end

  def copy_tmp(source, target, name, ignore = nil)
    # 一時ディレクトリーにコピー
    target = File.join(target, name)
    @logger.info("#{target}を作成します。")
    FileUtils.mkdir_p(target)
    copy(source, target, ignore)
  end

  def remove_tmp(target)
    # 一時ディレクトリーを削除
    @logger.info("一時ディレクトリー(#{target})を削除します。")
    if Dir.exist?(target) == true
      remove(target, 0)
    else
      @logger.info("#{target}が存在しないためパスします。")
    end
  end

  def compress(target, format); end
end
