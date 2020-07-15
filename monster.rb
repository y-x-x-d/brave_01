#モンスタークラス
#スライム時は通常攻撃のみ
#スライムのHPが半分になると、ドラゴンに変身する、変身後は攻撃力が上がる

require './character'

class Monster < Character
  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  #オーバーライド
  def initialize(**params)
    super(
      name: params[:name],
      hp: params[:hp],
      offence: params[:offence],
      defense: params[:defence]
    )

    #モンスターが変身したかを判定するフラグ
    @transform_flag = false
    #変身のトリガーとなる値(HPの半分)の計算
    @trigger_of_transform = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    if @hp <= @trigger_of_transform && @transform_flag == false
      @transform_flag = true
      transform
    end

    #スライムは通常攻撃しかない
    damage = calculate_damage(brave)

    cause_damage(target: brave, damage: damage)

    #messageの呼び出し
    attack_message
    damage_message(target: brave, damage: damage)

  end


private

   def calculate_damage(target)
     @offence - target.defence
   end

   # def calculate_special_attack
   #   @offence * SPECIAL_ATTACK
   # end

   def cause_damage(**params)
     target = params[:target]
     damage = params[:damage]

     target.hp -= damage

     target.hp = 0 if target.hp < 0
   end

   #変身について
   def transform
     #変身後の名前を定義
     transform_name = "ドラゴン"

     #transform_messageの呼び出し
     taransform_message(origin_name: @name, taransform_name: tansform_name)

     @offence *= POWER_UP_RATE

     @name = transform_name
   end

end
