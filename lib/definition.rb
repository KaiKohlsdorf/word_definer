class Definition
  attr_reader :id
  attr_accessor :definition, :word_id

  @@definitions = {}
  @@total_rows = 0

  def initialize(definition, word_id, id)
    @definition = definition
    @word_id = word_id
    @id = id || @@total_rows += 1
  end

  def ==(definition_to_compare)
    (self.definition() == definition_to_compare.definition()) && (self.word_id() == definition_to_compare.word_id())
  end

  def self.all
    @@definitions.values
  end

  def save
    @@definitions[self.id] = Definition.new(self.definition, self.word_id, self.id)
  end

  def self.find(id)
    @@definitions[id]
  end

  def update(definition, word_id)
    self.definition = definition
    self.word_id = word_id
    @@definitions[self.id] = Definition.new(self.definition, self.word_id, self.id)
  end

  def delete
    @@definitions.delete(self.id)
  end

  def self.clear
    @@definitions = {}
  end

  def self.find_by_word(wrd_id)
    definitions = []
    @@definitions.values.each do |definition|
      if definition.word_id == wrd_id
        definitions.push(definition)
      end
    end
    definitions
  end

  def word
    Word.find(self.word_id)
  end
end