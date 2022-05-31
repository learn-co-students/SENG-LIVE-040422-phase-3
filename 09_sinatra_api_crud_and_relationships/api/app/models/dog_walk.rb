class DogWalk < ActiveRecord::Base
  belongs_to :dog
  belongs_to :walk

  scope :with_poop, -> { where(pooped: true) }

  delegate :formatted_time, to: :walk


  # custom setter methods like this will be invoked when a key matching their name is passed to update or create on a DogWalk
  # see the dog_walk_params within the DogWalksController for reference
  def walk_time=(time)
    # if we've already saved this dog_walk, it will have an associated walk already, so update that walk's time to the time passed as an argument
    if self.walk
      self.walk.update(time: time)
    else
      # if we're creating a new dog_walk, then there won't be an associated walk yet, so create it and associate it
      self.walk = Walk.create(time: time)
    end
  end
end