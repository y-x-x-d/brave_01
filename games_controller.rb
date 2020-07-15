# games_controller.rb = ループ処理などの処理を制御する部分

require './message_dialog'

class GamesController
  #ミックスイン
  include MessageDialog

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  #バトルの処理
  def battle(**params)
    build_characters(params)

    loop do
      # HPが０になったら無限ループを終了
      @brave.attack(@monster)
      break if battle_end?
      @monster.attack(@brave)
      break if battle_end?
    end

    battle_judgment
  end





private
 #キャラクターのインスタンスをインスタンス変数に格納（引数を渡さなくてすむ）
  def build_characters(**params)
    @brave = params[:brave]
    @monster = params[:monster]
  end

 #キャラクターの勝敗でメッセージを変える
  def battle_judgment
    result = calculate_of_exp_and_gold
    end_message(result)
  end

  def calculate_of_exp_and_gold
    if brave_win?
      brave_win_flag = true
      exp = (@monster.offence + @monster.defense) * EXP_CONSTANT
      gold = (@monster.offence + @monster.defense) * GOLD_CONSTANT
    else
      brave_win_flag = false
      exp = 0
      gold = 0
    end
    {brave_win_flag: brave_win_flag, exp: exp, gold: gold}
  end

  #勇者とモンスター、どちらかのHPが０なったらバトルが終了する
  def battle_end?
    @brave.hp <= 0 || @monster.hp <= 0
  end

  #勇者の勝利判定
  #0より勇者のHPが大きい時に勝利が確定する
  def brave_win?
    @brave.hp > 0
  end
end
