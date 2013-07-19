class Battle < ActiveRecord::Base
  attr_accessible :money_transferred, :user_id, :opponent_id, :finished

  belongs_to :user, class_name: 'User', foreign_key: 'user_id', validate: true
  belongs_to :opponent, class_name: 'Opponent', foreign_key: 'opponent_id', validate: true
  belongs_to :winner, polymorphic: true, foreign_key: 'winner_id', validate: true
  belongs_to :loser, polymorphic: true, foreign_key: 'loser_id', validate: true

  def to_json
    return {
      encid: id,
      finished: finished,
      user: user.to_json,
      opponent: opponent.to_json,
      winner_id: winner_id,
      loser_id: loser_id,
    }
  end

  def self.start(user, opponent)
    return false if user == opponent
    battle = new(user_id: user.id, opponent_id: opponent.id, finished: false)
    user.in_battle = true
    transaction do
      battle.save
      user.save
    end
    return battle
  end

  def self.end(battle)
    user = battle.user
    user.in_battle = false
    battle.finished = true
    transaction do
      battle.save
      user.save
    end
    return true
  end
end
