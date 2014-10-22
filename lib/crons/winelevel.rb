class Crons::Winelevel
  def self.calculate
    Rails.logger.debug('Winelevel.calculate START')

    # 今は飲んだ本数(winenum)をそのままwinelevelとする
    users = User.all
    users.each { |user| user.update(winelevel: user.winenum) }

    Rails.logger.debug('Winelevel.calculate END')
  end
end