class SearchedShoe
  attr_accessor :model, :manufacturer, :errors
  
  def initialize args
    @model, @manufacturer = args[:model], args[:manufacturer] 
    @errors = []
  end
  
  def validate
    error_text = "Um eine Suche nach einem Schuh durchführen zu können, brauchen 
      wir mindestens einen Herstellernamen. Die Suche funktioniert besser, wenn 
      du auch einen Schuhmodell angibst. "
    valid? ? @errors.clear : @errors << error_text 
  end
  
  def valid?
    @manufacturer.present?
  end
end