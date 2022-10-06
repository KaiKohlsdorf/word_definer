class Word
  @@words = {}

  def initialize(name, definition)
    @name = name
    @definition = definition
  end

  def self.all
    @@words.values()
  end
end

