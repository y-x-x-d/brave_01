#親クラス

require './message_dialog'

#(ミックスインするので、「<」は必要ない)
class Character
  #MessageDialogをミックスイン（module）
  include MessageDialog

  attr_reader :offence, :defence
  attr_accessor :name, :hp

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offence = params[:offence]
    @defence = params[:defence]
  end
end
