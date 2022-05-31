class DogWalksController < ApplicationController
  post "/dog_walks" do 
    
  end

  patch "/dog_walks/:id" do
    
  end

  delete "/dog_walks/:id" do
   
  end

  private 

  # a method used to specify which keys are allowed through params into the controller
  # we use this method to create a list of what's permitted to be passed to .create or .update
  # within controller actions.
  def dog_walk_params
    allowed_params = %w(dog_id walk_time pooped)
    params.select {|param,value| allowed_params.include?(param)}
  end
end