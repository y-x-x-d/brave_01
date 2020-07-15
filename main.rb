#プログラムを実行する部分
#継承など

require './brave'
require './monster'
require './character'
require './games_controller'

games_controller = GamesController.new
#インスタンス化

#勇者クラスをインスタンス化
jhonny = Brave.new(name:"ジョニー", hp:500, offence:150, defence:100)

#モンスタークラスのインスタンス化
slime = Monster.new(name:"スライム", hp:200, offence:150, defence:100)

#GamesControllerクラスのbattleメソッドを使用（勇者とモンスター）
games_controller.battle(brave: jhonny, monster: slime)
