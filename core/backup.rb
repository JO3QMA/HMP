# frozen_string_literal: true

require 'fileutils'
require 'zip'

# バックアップ処理
class Backup
  def initialize
    # 初期化
  end

  def copy(source, target, _name, _ignore = nil)
    FileUtils.cp_r(source, target)
  end

  def remove(target, _keep)
    FileUtils.rm_r(target)
  end

  def compress(target, format); end
end
