class DogsController < ApplicationController
  
  # use includes so that when we serialize associated data we don't end up triggering additional queries for each item in the collection.
  # using .includes allows us to avoid the N+1 query problem
  get "/dogs" do 
    serialize(Dog.includes(:walks))
  end

  get "/dogs/:id" do 
    dog = Dog.find(params[:id])
    serialize(dog)
  end

  post "/dogs" do 
    serialize(Dog.create(dog_params))
  end

  patch "/dogs/:id" do
    dog = Dog.find(params[:id])
    dog.update(dog_params)
    serialize(dog)
  end

  delete "/dogs/:id" do 
    dog = Dog.find(params[:id])
    dog.destroy
    serialize(dog)
  end

  private 

  # a method used to specify which keys are allowed through params into the controller
  # we use this method to create a list of what's permitted to be passed to .create or .update
  # within controller actions.
  def dog_params
    allowed_params = %w(name birthdate breed image_url)
    params.select {|param,value| allowed_params.include?(param)}
  end

  # add an include option so that dog_walks are included when we request information about dogs. This will ensure that we'll be able to see from our react client the recent walks that our dogs have been on
  def serialize(dog)
    dog.to_json(
      methods: :age,
      include: {
        dog_walks: {
          methods: [:formatted_time]
        }
      }
    )
  end
end