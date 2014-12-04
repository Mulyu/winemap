class Crons::Winelevel
  def self.calculate
    Rails.logger.debug('Winelevel.calculate START')

    # 今は飲んだ本数(winenum)をそのままwinelevelとする
    users = User.all
    users.each { |user| user.update(winelevel: Wine.where(:user_id => user.id).count ) }

    # 未登録ユーザーのレベル設定
    User.find(1).update(winelevel: -1)

    Rails.logger.debug('Winelevel.calculate END')
  end
end