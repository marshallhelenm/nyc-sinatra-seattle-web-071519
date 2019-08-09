class LandmarksController < ApplicationController
  get '/landmarks/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figures = Figure.all
    erb :'/landmarks/new'
  end

  get '/landmarks/:id' do #show page
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/show"
  end

  get '/landmarks' do
    @landmarks = Landmark.all 
    erb :"/landmarks/index" 
  end

  post '/landmarks' do
    @landmark = Landmark.new(params[:landmark][:name], params[:landmark][:year_completed])
    @landmark.save
    redirect :"/landmarks/#{@landmark.id}"
  end

  delete '/landmarks/:id' do
    @landmark = Landmark.find(params[:landmark][:id])
    @landmark.destroy
    redirect :"/landmarks"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/edit"
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    erb :"/landmarks/#{@landmark.id}"
  end
end
