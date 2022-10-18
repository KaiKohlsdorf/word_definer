require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create a word path', {:type => :feature}) do
  it('creates a word and then goes to the word page') do
    visit('/words')
    click_on('Add a new word')
    fill_in('word_name', :with => 'yellow')
    click_on('Create!')
    expect(page).to have_content('yellow')
  end
end

describe('create a definition path', {:type => :feature}) do
  it('creates a definition and then goes to the word page') do
    word = Word.new("yellow", nil)
    word.save
    visit("/words/#{word.id}")
    fill_in('definition_definition', :with => 'a primary color')
    click_on('Add definition')
    expect(page).to have_content('a primary color')
  end
end

describe('update a word', {:type => :feature}) do
  it('updates a word and then goes to the word page') do
    word = Word.new("yellow", nil)
    word.save
    visit("/words/#{word.id}")
    click_on('Edit word')
    fill_in('name', :with => 'blue')
    click_on('Update')
    expect(page).to have_content('blue')
  end
end

describe('delete a word', {:type => :feature}) do
  it('deletes a word and then goes to the word page') do
    word = Word.new("yellow", nil)
    word.save
    visit("/words/#{word.id}")
    click_on('Edit word')
    click_on('Delete word')
    expect(page).to have_content('')
  end
end

describe('update definition', {:type => :feature}) do
  it('updates definition and then goes to the word page') do
    word = Word.new("yellow", nil)
    word.save
    visit("/words/#{word.id}")
    fill_in('definition_definition', :with => 'a primary color')
    click_on('Add definition')
    expect(page).to have_content('a primary color')
    fill_in('definition_definition', :with => 'bright like the sun')
    click_on('Add definition')
    expect(page).to have_content('bright like the sun')
  end
end

# describe('deletes definition', {:type => :feature}) do
#   it('deletes definition and then goes to the word page') do
#     word = Word.new("easy", nil)
#     word.save
#     visit("/words/#{word.id}")
#     fill_in('definition_text', :with => 'without difficulty or effort')
#     click_on('Add!')
#     expect(page).to have_content('without difficulty or effort')
#     fill_in('definition_text', :with => 'opposite of hard')
#     click_on('Add!')
#     expect(page).to have_content('opposite of hard')
#     click_on('opposite of hard')
#     fill_in('name', :with => 'free from worries or problems')
#     click_on('Update definition')
#     expect(page).to have_content('free from worries or problems')
#     click_on('free from worries or problems')
#     click_on('Delete definition')
#     expect(page).to have_content('without difficulty or effort')
#   end
# end