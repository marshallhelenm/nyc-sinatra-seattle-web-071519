class FiguresController < ApplicationController
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures/:id' do #show page
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get '/figures' do
    @figures = Figure.all 
    erb :"/figures/index" 
  end

  def associate_landmark(figure, params)
    if !params[:landmark][:name] == ""
      figure.landmarks << new_landmark(params)  
    else
      @landmarks = Landmark.find(params[:figure][:landmark_ids])
      @landmarks.each do |landmark|
        figure.landmarks << landmark
      end
    end
    figure.save
  end

  def associate_title(figure, params)
    if !params[:title][:name] == ""
      figure.titles << new_title(params)  
    else
      binding.pry
      @titles = Title.find(params[:title][:name])
      @titles.each do |title|
        figure.titles << title
      end
    end
    figure.save
  end

  def new_title(params)
    title = Title.new(params[:title][:name])
    title
  end

  def new_landmark(params)
    landmark = Landmark.new(params[:landmark][:name])
    landmark
  end

  post '/figures' do
    @figure = Figure.new(name: params[:figure][:name])
    associate_title(@figure, params)
    associate_landmark(@figure, params)
    @figure.save
    redirect :"/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
    @figure = Figure.find(params[:figure][:id])
    @figure.destroy
    redirect :"/figures"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"/figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:figure][:id])
    @figure.update(name: params[:figure][:name])
    @figure.titles << new_title(params)
    @figure.landmarks << new_landmark(params)
    erb "/figures/#{@figure.id}"
  end

  def new_title(params)
    title = Title.new(params[:title][:name])
    title
  end

  def new_landmark(params)
    landmark = Landmark.new(params[:landmark][:name])
    landmark
  end



end
