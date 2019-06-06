class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    @pet = Pet.create(params["pet"])
    if params["owner"]["owner_ids"] != nil
      @pet.owner = Owner.find_by(id: params["owner"]["owner_ids"][0])
      @pet.save
    elsif params["owner"]["name"] != nil
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = owner
      @pet.save
    end
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    if params["pet"]["owner_ids"] != nil
      # binding.pry
      @pet.owner = Owner.find_by(id: params["pet"]["owner_ids"])
      @pet.save
    end
    if params["owner"]["name"] != ""
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = owner
      @pet.save
    end
    if params["pet"]["name"] != nil
      @pet.name = params["pet"]["name"]
      @pet.save
    end
    redirect "pets/#{@pet.id}"
  end
end
