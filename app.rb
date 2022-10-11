require('sinatra')
require('sinatra/reloader')
require('./lib/word')
require('./lib/definition')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  redirect to('/words')
end

get('/words') do
  @words = Word.all
  erb(:words)
end

get('/words/new') do
  erb(:new_word)
end

post('/words') do
  name = params[:word_name]
  word = Word.new(name, nil)
  word.save()
  redirect to('/words')
end

get('/words/:id') do
  @word =Word.find(params[:id].to_i())
  erb(:word)
end

get('/words/:id/edit') do
  @word = Word.find(params[:id].to_i())
  erb(:edit_word)
end

patch('/words/:id') do
  if params[:name] != ""
    @word = Word.find(params[:id].to_i())
    @word.update(params[:name])
  end
  redirect to('/words')
end

delete('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.delete()
  redirect to('/words')
end

get('/words/:id/definitions/:definition_id') do
  @definition = Definition.find(params[:definition_id].to_i())
  erb(:definition)
end

post('/words/:id/definitions') do
  @word = Word.find(params[:id].to_i())
  definition = Definition.new(params[:definition_definition], @word.id, nil)
  definition.save()
  erb(:word)
end

patch('/words/:id/definitions/:definition_id') do
  @word = Word.find(params[:id].to_i())
  if params[:definition] != ""
    definition = Definition.find(params[:definition_id].to_i())
    definition.update(params[:definition], @word.id)
  end
  erb(:word)
end

delete('/words/:id/definitions/:definition_id') do
  definition = Definition.find(params[:song_id].to_i())
  definition.delete
  @word = Word.find(params[:id].to_i())
  erb(:word)
end