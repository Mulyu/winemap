class Crons::Winelevel
  def self.calculate
    Rails.logger.debug('Winelevel.calculate START')

    # connect to user model test
    user = User.find(1)
    puts "#{user.name}"

    Rails.logger.debug('Winelevel.calculate END')
  end
end