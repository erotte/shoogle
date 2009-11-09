class SearchedShoe < ActiveRecord::NoTable
  attr_accessor :model, :manufacturer
  ERROR_TEXT = "Um eine Suche nach einem Schuh durchführen zu können, brauchen 
    wir mindestens einen Herstellernamen. Die Suche funktioniert besser, wenn 
    du auch einen Schuhmodell angibst. "

  validates_length_of :manufacturer, :minimum => 2, :message => ERROR_TEXT
  
  def initialize args
    @model, @manufacturer = args[:model], args[:manufacturer] 
  end
  
end