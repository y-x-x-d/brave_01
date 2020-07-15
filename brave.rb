#勇者クラス

require './character'

#クラスを構成していく
#名前やステータスなどは先にインスタンス化したので攻撃を定義

class Brave < Character
  #必殺技の定数を定義
  SPECIAL_ATTACK = 1.5

  #攻撃メソッドを定義
  def attack(monster)
    #攻撃の判定(決定:decision)
    attack_type = decision_attack_type

    #キーワード引数を定義（ダメーシ計算）引数の依存を解放する
    damage = calculate_damage(target: monster, attack_type: attack_type)

    #ダメージを反映させる
    cause_damage(target: monster, damage: damage)

    #messageの呼び出し
    attack_message(attack_type: attack_type)
    damage_message(target: monster, damage: damage)
  end


private
    #攻撃の判定をインスタンス化
   def decision_attack_type
     #0~3の間（３回の攻撃のうち１回）でランダムに、必殺技と通常攻撃を分ける
     attack_num = rand(4)

     if attack_num == 0
       "special_attack"
     else
       "normal_attack"
     end
   end

   #ダメージ計算の定義
    def calculate_damage(**params)
      target = params[:target]
      attack_type = params[:attack_type]

      if attack_type == "special_attack"
        calculate_special_attack - target.defence
      else
        @offence - target.defence
      end
    end

  #必殺技
    def calculate_special_attack
      @offence * SPECIAL_ATTACK
    end

  #ダメージの反映
    def cause_damage(**params)
      target = params[:target]
      damage = params[:damage]

      target.hp -= damage

      target.hp = 0 if target.hp < 0

    end

end
