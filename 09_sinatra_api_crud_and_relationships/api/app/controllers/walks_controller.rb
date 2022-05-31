class WalksController < ApplicationController

  get "/walks" do 
    serialize(Walk.all)
  end
 
  # create a walk based on information in walk_params
  # serialize the walk as JSON
  post "/walks" do 
    puts "Params: #{walk_params}"
    serialize(Walk.create(walk_params))
  end

  # find the walk associated with the request (using params[:id])
  # use the ActiveRecord #update method to bring the walk up to date with walk_params
  # serialize the updated walk as JSON
  patch "/walks/:id" do 
    walk = Walk.find(params[:id])
    walk.update(walk_params)
    serialize(walk)
  end

  delete "/walks/:id" do 
    walk = Walk.find(params[:id])
    # when we delete a walk, our database will also remove all associated dog_walks (because of the dependent: :destroy option) so get the information required to create the walk with the associated dogs again
    response = walk.to_json(
      only: [:time],
      methods: [:dog_ids]
    )
    walk.destroy
    response
  end

  private 

  # a method used to specify which keys are allowed through params into the controller
  # we use this method to create a list of what's permitted to be passed to .create or .update
  # within controller actions.
  def walk_params
    allowed_params = %w(time dog_ids)
    params.select {|param,value| allowed_params.include?(param)}
  end

  # include dogs with walks so that our client can display which dogs are on a particular walk
  def serialize(objects)
    objects.to_json(
      methods: :formatted_time,
      include: {
        dogs: {
          only: [:id, :name, :image_url]
        }
      }
    )
  end
end