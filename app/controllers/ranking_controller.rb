class RankingController < ApplicationController
  def index
    @country_ranking = Country.where(ranking: 1..100).order(:ranking)
    @localregion_ranking = Localregion.where(ranking: 1..100).order(:ranking)
    @user_ranking = User.where(ranking: 1..100).order(:ranking)
  end
end
