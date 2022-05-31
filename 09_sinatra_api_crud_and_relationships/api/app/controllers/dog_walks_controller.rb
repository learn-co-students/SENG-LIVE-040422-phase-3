class DogWalksController < ApplicationController
  # create a new dog walk based on the information inside of dog_walk_params
  # serialize the newly create dog walk as JSON
  post "/dog_walks" do 
    serialize(DogWalk.create(dog_walk_params))
  end

  # find the dog_walk associated with the request (using params[:id])
  # use the ActiveRecord #update method to bring the walk up to date with dog_walk_params
  # serialize the updated dog_walk as JSON
  patch "/dog_walks/:id" do
    dog_walk = DogWalk.find(params[:id])
    # puts dog_walk.inspect
    dog_walk.update(dog_walk_params)
    serialize(dog_walk)
  end

  # find the dog_walk associated with the request (using params[:id])
  # remove the dog_walk from the database
  # (optional) serialize the deleted dog_walk to enable client side undo feature
  # or add status 204 to indicate no content in the response due to a successful deletion 
  delete "/dog_walks/:id" do
    dog_walk = DogWalk.find(params[:id])
    dog_walk.destroy
    dog_walk.to_json
    # or do
    # status 204
  end

  private 

  # a method used to specify which keys are allowed through params into the controller
  # we use this method to create a list of what's permitted to be passed to .create or .update
  # within controller actions.
  # the walk_time parameter value is passed to the `walk_time=` method defined in the DogWalk model.
  def dog_walk_params
    allowed_params = %w(dog_id walk_time pooped)
    params.select {|param,value| allowed_params.include?(param)}
  end

  def serialize(objects)
    objects.to_json(methods: [:formatted_time])
  end
end