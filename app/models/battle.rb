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

  def did_end?
    !user.has_alive_pets? || !opponent.has_alive_pets?
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

  def self.make_turn(battle, type, params)
    user = User.find(params[:user_id])
    opponent = Opponent.find(params[:opponent_id])

    user_pet = Pet.find(params[:pet_id])
    opponent_pet = OpponentPet.find(params[:opponent_pet_id])

    # AI for opponent to select an action to do.
    opponent_action = opponent.make_action(user, params)

    user_action = user.make_action(opponent, type, params)

    turn = Turn.new
    user_battle_action = BattleAction.new(user_action)
    user_battle_action.owner_type = "user"

    opponent_battle_action = BattleAction.new(opponent_action)
    opponent_battle_action.owner_type = "opponent"

    if user_pet.speed >= opponent_pet.speed
      turn = Battle.take_turn(battle, turn, [user_battle_action, opponent_battle_action])
    else
      turn = Battle.take_turn(battle, turn, [opponent_battle_action, user_battle_action])
    end

    if turn.save
      return turn
    else
      puts "Error creating turn."
      return nil
    end
  end

  def self.take_turn(battle, turn, actions)
    user = battle.user
    opponent = battle.opponent

    actions.each do |action|
      turn.battle_actions << action
      if action.owner_type == "user"
        result = user.execute_action(action)
      else
        result = opponent.execute_action(action)
      end

      if !result[:pet_is_alive] || !result[:opponent_pet_is_alive]
        if battle.did_end?
          # end battle logic
          if battle.user.has_alive_pets?
            # user won
            user.won(battle, opponent)
          else
            # opponent won
            user.lost(battle, opponent)
          end
          action.battle_finished = true
          action.save
          return turn
        else
          # one pet died and needs to switch
          if (action.owner_type == "user" && !result[:pet_is_alive]) || (action.owner_type == "opponent" && !result[:opponent_pet_is_alive])
            # user pet died so switch out pets
          else
            # opponent pet died to opponent switches out pet
          end
        end
      end
      action.battle_finished = false
      action.save
    end

    return turn
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
