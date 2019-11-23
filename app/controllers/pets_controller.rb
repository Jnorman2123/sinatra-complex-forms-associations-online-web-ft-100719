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
    @pet = Pet.create(name: params[:pet][:name])
    binding.pry
    if Owner.find(params[:pet][:owner_id])
      @owner = Owner.find(params[:pet][:owner_id])
      @pet.owner = @owner
      @owner.pets << @pet
    else
      @new_owner = Owner.create(name: params[:owner][:name]) if !params[:owner][:name].empty?
      @new_owner.pets << @pet
    end


    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
