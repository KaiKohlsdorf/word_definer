require 'rspec'
require 'word'
require 'definition'

describe '#Word' do 

  before(:each) do
    Word.clear()
  end
  
  describe('.all') do 
    it("returns an empty array when there are no words") do
      expect(Word.all).to(eq([]))
    end
  end

  describe ('#save') do 
    it("saves a word") do
      word = Word.new("apple", nil)
      word.save()
      word2 = Word.new("yellow", nil)
      word2.save()
      expect(Word.all).to(eq([word, word2]))
    end
  end

  describe('#==') do
   it("is the same word if it has the same attributes as another word") do
      word = Word.new("apple", nil)
      word2 = Word.new("apple", nil)
      expect(word).to(eq(word2))
   end
  end

  describe('.clear') do
    it("clears all words") do
      word = Word.new("apple", nil)
      word.save()
      word2 = Word.new("yellow", nil)
      word2.save()
      Word.clear()
      expect(Word.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a word by id") do
      word = Word.new("apple", nil)
      word.save()
      word2 = Word.new("yellow", nil)
      word2.save()
      expect(Word.find(word.id)).to(eq(word))
    end
  end

  describe('#update') do
    it("updates a word by id") do
      word = Word.new("apple", nil)
      word.save()
      word.update("orange")
      expect(word.name).to(eq("orange"))
    end
  end

  describe('#delete') do
    it("deletes a word by id") do
      word = Word.new("apple", nil)
      word.save()
      word2 = Word.new("yellow", nil)
      word2.save()
      word.delete()
      expect(Word.all).to(eq([word2]))
    end
  end

  describe('#definitions') do
    it("returns a word's definitions") do
      word = Word.new("apple", nil)
      word.save()
      definition = Definition.new("a red fruit", word.id, nil)
      definition.save()
      definition2 = Definition.new("tree that bears apples", word.id, nil)
      definition2.save()
      expect(word.definitions).to(eq([definition, definition, definition2]))
    end
  end

  describe('#word') do
    it("finds the word a definition belongs to") do
      definition = Definition.new("a red fruit", @word_id, nil)
      definition.save()
      expect(definition.word()).to(eq(@word))
    end
  end
end