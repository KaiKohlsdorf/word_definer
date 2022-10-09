require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an word path', {:type => :feature}) do
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
    fill_in('definition_name', :with => 'a primary color')
    click_on('Add definition')
    expect(page).to have_content('a primary color')
  end
end