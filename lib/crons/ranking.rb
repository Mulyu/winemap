class Crons::Ranking
  def self.update
    Rails.logger.debug('Ranking.update START')

    ### User
    # winelevelが高い順
    users = User.all
    users.sort_by(&:winelevel).reverse.map(&:id).each.with_index(1) do |id, rank|
      User.update(id, ranking: rank)
    end

    ### Country
    # ワインの評価値の平均

    ### Localregion
    # ワインの評価値の平均

    Rails.logger.debug('Ranking.update END')
  end
end