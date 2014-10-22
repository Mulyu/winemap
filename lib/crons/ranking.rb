class Crons::Ranking
  class << self
    def update
      Rails.logger.debug('Ranking.update START')

      update_user

      update_country

      update_localregion

      Rails.logger.debug('Ranking.update END')
    end

    private
      def update_user
        # winelevelが高い順
        users = User.all
        users.sort_by(&:winelevel).reverse.map(&:id).each.with_index(1) do |id, rank|
          User.update(id, ranking: rank)
        end
      end

      def update_country
        country_ids = (1..Country.count).to_a

        # ワインの評価値の平均が高い順
        # .find_all以降では、winesのシードデータに存在しないcountry_idが含まれているため、それを除去している(正しいデータを用意すればいらなくなるはず)
        rank_countries = Wine.group(:country_id).order('AVG(score) DESC').map(&:country_id).find_all { |rc| country_ids.include?(rc) }
        rank_countries.each.with_index(1) { |country_id, rank| Country.update(country_id, ranking: rank)  }

        # 登録されていないcountryのrankingを調整
        country_ids.reject { |id| rank_countries.include?(id) }.each { |country_id| Country.update(country_id, ranking: 9_999_999) }
      end

      def update_localregion
        localregion_ids = (1..Localregion.count).to_a

        # ワインの評価値の平均が高い順
        rank_localregions = Wine.group(:localregion_id).order('AVG(score) DESC').map(&:localregion_id).find_all { |rl| localregion_ids.include?(rl) }
        rank_localregions.each.with_index(1) { |localregion_id, rank| Localregion.update(localregion_id, ranking: rank) }

        # 登録されていないlocalregionのrankingを調整
        localregion_ids.reject { |id| rank_localregions.include?(id) }.each { |localregion_id| Localregion.update(localregion_id, ranking: 9_999_999) }
      end
  end
end